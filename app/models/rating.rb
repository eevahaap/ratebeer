class Rating < ActiveRecord::Base

  include RatingAverage

  belongs_to :beer

  def to_s
    @rating
  end
end
