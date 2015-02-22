class Brewery < ActiveRecord::Base

  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, :inclusion => { :in => proc { 1042..0.years.ago.year } }

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

 def to_s
   return name
 end

end
