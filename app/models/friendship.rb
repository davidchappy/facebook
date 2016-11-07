class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  validates :status,  :inclusion => { in: ['pending', 'friends'] }
end
