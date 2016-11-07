class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable  
  devise :database_authenticatable, :registerable, :recoverable, 
  :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :posts
  has_many :notifications
  has_many :comments
  has_many :friendships
  has_many :friends, :through => :friendships

end
