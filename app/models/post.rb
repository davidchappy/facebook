class Post < ApplicationRecord
  belongs_to  :user
  has_many    :comments
  has_many    :likes
  default_scope -> { order(created_at: :desc) }

  validates :content, :user_id, presence: true
  validates :content, length: { minimum: 6, maximum: 5000 }
end
