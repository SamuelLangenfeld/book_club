class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user_id, uniqueness: {scope: :book_id}
  validates :book_id, uniqueness: {scope: :user_id}
  validates :user_id, presence: true
  validates :book_id, presence: true
end
