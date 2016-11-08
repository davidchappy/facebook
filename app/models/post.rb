class Post < ApplicationRecord
  belongs_to  :user
  has_many    :comments,  dependent: :destroy
  has_many    :likes,     dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  validates :content, :user_id, presence: true
  validates :content, length: { minimum: 6, maximum: 5000 }
end
