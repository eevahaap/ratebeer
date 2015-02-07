class User < ActiveRecord::Base

  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: {in: 3..15}
  validates :password, format: { with: /(?=.*\d)(?=.*[A-Z])/, message: "must have at least one capital and one number" }
  validates_length_of :password, minimum: 4

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

end
