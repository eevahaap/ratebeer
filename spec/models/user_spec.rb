require 'rails_helper'

RSpec.describe User, type: :model do


  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")

  end

  describe "is not saved" do

   it "with password that's too short" do
      user = User.create username: "Pekka", password: "A1", password_confirmation: "A1"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
     end

    it "with password that doesn't contain a non-letter character" do
     user = User.create username: "Pekka", password: "abcdefgh", password_confirmation: "abcdefgh"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end

    it "without a proper password" do
      user = User.create username: "Pekka"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
      end
    end


  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }



    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do


      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(20.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end

  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end


end
