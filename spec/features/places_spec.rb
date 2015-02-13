require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
                                 [ Place.new( name:"Oljenkorsi", id: 1 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple places are returned, they're all shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kirkkonummi").and_return(
                                 [ Place.new( name:"Rosso", id: 1 ), Place.new( name:"Kultainen Tai", id: 2 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kirkkonummi')
    click_button "Search"

    expect(page).to have_content "Rosso"
    expect(page).to have_content "Kultainen Tai"

  end

  it "if none are returned, show 'No locations message' on index page" do
    allow(BeermappingApi).to receive(:places_in).with("kantvik").and_return([ ])

    visit places_path
    fill_in('city', :with => "kantvik")
    click_button "Search"
    expect(page).to have_content "No locations in kantvik"
  end

end