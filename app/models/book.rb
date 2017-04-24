class Book < ApplicationRecord
    has_one :meeting, dependent: :destroy
    has_many :notes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :group_pics
end
