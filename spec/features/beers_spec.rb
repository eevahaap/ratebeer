require 'rails_helper'

include OwnTestHelper

describe "Beers" do

  let!(:user) { FactoryGirl.create (:user) }
  let!(:brewery) { FactoryGirl.create(:brewery, name: "Koff") }



  it "creates a new beer" do
    sign_in(user)
    visit new_beer_path
    fill_in('beer[name]', with:'Karhu')
    select('Koff', from: 'Brewery')
    click_button "Create Beer"
    expect(Beer.count).to eq(1)
    expect(page).to have_content('Karhu')
  end

  it "shows error when no name given" do

    visit new_beer_path
    click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name can't be blank"
  end


end