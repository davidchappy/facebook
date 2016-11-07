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
  has_many :likes

end
