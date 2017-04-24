class GroupPic < ApplicationRecord
  belongs_to :book
  mount_uploader :picture, PictureUploader
  validates :picture, presence: true
  validates :book_id, presence: true
end
