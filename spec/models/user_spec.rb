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
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }



    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:30

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(20.0)
    end
  end

end
