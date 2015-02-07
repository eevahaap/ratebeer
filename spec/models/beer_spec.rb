require 'rails_helper'

RSpec.describe Beer, type: :model do

  let(:brewery) {Brewery.create name: "Koff", year: 1873}

  describe "is not saved" do

    it "when beer has no name" do
      beer= Beer.new
      beer.brewery = brewery
      expect(beer.valid?).to be(false)
    end

    it "when beer has no style specified" do
      beer = Beer.new
      beer.name = "Karhu"
      beer.brewery = brewery
      expect(beer.valid?).to be(false)
    end

  end

  describe "is saved" do

    it "when beer has a name, style and a brewery" do
      beer = Beer.new
      beer.brewery = brewery
      beer.style = "Lager"
      beer.name = "Karhu"
      expect(beer.valid?).to be(true)

    end

  end


end
