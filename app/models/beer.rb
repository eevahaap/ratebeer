class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def to_s
    return [name, brewery.name].join(", ")
  end

end

