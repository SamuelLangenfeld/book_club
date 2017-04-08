class Book < ApplicationRecord
    has_one :meeting
    has_many :notes
    has_many :comments
end
