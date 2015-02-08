require 'rails_helper'

describe 'Places' do
  location = 'kumpula'

  it 'if one is returned by the API, it is shown at the page' do
    allow(BeerMappingApi).to receive(:places_in).with(location).and_return([ Place.new(name: 'Oljenkorsi', id: 1)])

    visit places_path
    fill_in('city', with: location)
    click_button 'Search'

    expect(page).to have_content 'Oljenkorsi'
  end

  it 'if none is returned by the API, notice is shown at the page' do
    allow(BeerMappingApi).to receive(:places_in).with(location).and_return([])

    visit places_path
    fill_in('city', with: location)
    click_button 'Search'

    expect(page).to have_content "No locations in #{location}"
  end

  it 'if multiple is returned by the API, they are shown at the page' do
    places = ['Oljenkorsi', 'Korsenolji', 'Soljenkorsi']
    id = 1;

    allow(BeerMappingApi).to receive(:places_in).with(location).and_return([
        places.each do | place |
          Place.new(name: place, id:id += 1)
        end
      ])

    visit places_path
    fill_in('city', with: location)
    click_button 'Search'

    places.each do | place |
      expect(page).to have_content place
    end
  end
end