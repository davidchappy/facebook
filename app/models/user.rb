class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable  
  devise :database_authenticatable, :registerable, :recoverable, 
  :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  validates :name, :email, :password, presence: true
  validates :name,  length: { minimum: 5, maximum: 120 }
  validates :email, length: { maximum: 254 }, uniqueness: true
  validates_format_of :email, :with => Devise::email_regexp

  has_many :posts, dependent: :destroy
  has_many :notifications
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

end
