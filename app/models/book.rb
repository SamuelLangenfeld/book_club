class Book < ApplicationRecord
    has_one :meeting, dependent: :destroy
    has_many :notes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :group_pics, dependent: :destroy
    has_many :ratings, dependent: :destroy


    def get_total_rating
      rate_total= 0.0
      ratings.each do |rating|
        rate_total+=rating.points
      end
      unless ratings.empty?
        rate_avg=rate_total/ratings.size
        sprintf("%0.01f", rate_avg)
      else
        "This book has not been rated."
      end
    end

end