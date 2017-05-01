class Note < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :content, presence: true
  validates :user, presence: true
  validates :book, presence: true
end
