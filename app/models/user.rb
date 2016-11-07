class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable  
  devise :database_authenticatable, :registerable, :recoverable, 
  :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :posts
  has_many :friends, class_name: "User"
  has_many :notifications

end
