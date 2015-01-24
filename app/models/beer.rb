class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings
end

class Rating < ActiveRecord::Base
  belongs_to :beer
end