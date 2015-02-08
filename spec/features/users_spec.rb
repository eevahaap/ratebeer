require 'rails_helper'

include OwnTestHelper

describe "User" do
  before :each do
    @user = FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "show page" do
    let(:beer) { FactoryGirl.create(:beer, name: "Wheat", style: "Wheat") }

    it "shows ratings done by user" do

      sign_in(username:"Pekka", password:"Foobar1")

      FactoryGirl.create(:rating, score: 10, user: @user, beer: beer)
      FactoryGirl.create(:rating, score: 15, user: @user, beer: beer)

      visit user_path(@user.id)

      expect(page).to have_content("has made 2 ratings")
      expect(page).to have_content("Wheat 10")
      expect(page).to have_content("Wheat 15")
    end
    it "removed rating is taken out from database" do
      sign_in(username:"Pekka", password:"Foobar1")
      FactoryGirl.create(:rating, score: 10, user: @user, beer: beer)
      visit user_path(@user.id)

      click_link('delete')


      expect(page).to have_content('has made 0 ratings')
    end
    it "shows favorite style of beer" do
      FactoryGirl.create(:rating, score: 10, user: @user, beer: beer)
      visit user_path(@user.id)
      expect(page).to have_content("favorite style: Wheat")
    end
    it "shows favorite brewery" do
      FactoryGirl.create(:rating, score: 10, user: @user, beer: beer)
      visit user_path(@user.id)
      expect(page).to have_content("favorite brewery: anonymous")
    end
  end


end


