class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable  
  devise :database_authenticatable, :registerable, :recoverable, 
  :rememberable, :trackable, :validatable, :confirmable, 
  :omniauthable, :omniauth_providers => [:facebook]

  validates :name, :email, :password, presence: true
  validates :name,  length: { minimum: 5, maximum: 120 }
  validates :email, length: { maximum: 254 }, uniqueness: true
  validates_format_of :email, :with => Devise::email_regexp

  has_many :posts, dependent: :destroy
  has_many :comments

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :likes

  def request_friendship(target_user)
    friendship = friendships.create(user_id: self.id, friend_id: target_user.id)
    target_user.inverse_friendships << friendship
  end

  def all_friendships
    Friendship.where('friend_id = ? OR user_id = ?', self.id, self.id)
  end

  def relationship_status(target_user)
    if all_friends.include?(target_user)
      self.find_friendship(target_user).status
    else
      'Not Friends'
    end
  end

  def is_friend?(target_user)
    self.all_friends.include?(target_user)
  end

  def find_friendship(target_user)
    friend = Friendship.where("friend_id = ? AND user_id = ?", target_user.id, self.id).take
    inverse_friend = Friendship.where("friend_id = ? AND user_id = ?", self.id, target_user.id).take
    friend.nil? ? inverse_friend : friend
  end

  def all_friends
    # needs serious refactoring
    requested_friends = self.friends
    requesting_friends = self.inverse_friends
    all_friends = []
    User.all.each do |user|
      all_friends << user if requested_friends.include?(user)
      all_friends << user if requesting_friends.include?(user)
    end
    all_friends
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships WHERE user_id = :user_id AND status = 'friends'"
    inverse_ids = "SELECT user_id FROM friendships WHERE friend_id = :user_id AND status = 'friends'"
    Post.where("user_id IN (#{friend_ids}) OR user_id IN (#{inverse_ids}) OR user_id = :user_id", user_id: id)
  end

  def likes?(post)
    self.likes.include?(user_like(post))
  end

  def user_like(post)
    Like.where(user_id: self.id, post_id: post.id).take
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.uid = auth.uid
      user.provider = auth.provider
      user.skip_confirmation!
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def after_confirmation
    WelcomeMailer.welcome(self).deliver unless self.invalid?
  end

end
