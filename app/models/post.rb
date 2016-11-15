class Post < ApplicationRecord
  belongs_to  :user
  has_many    :comments,  dependent: :destroy
  has_many    :likes,     dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validate    :picture_size

  validates :content, :user_id, presence: true
  validates :content, length: { minimum: 6, maximum: 5000 }

  private 

    def picture_size
      if picture.size > 3.megabytes
        errors.add(:picture, "should be less than 3MB")
      end
    end
end
