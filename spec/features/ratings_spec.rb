require 'rails_helper'

include OwnTestHelper

describe 'Rating' do

  let!(:brewery) { FactoryGirl.create :brewery, name: 'Koff' }
  let!(:beer1) { FactoryGirl.create :beer, name: 'iso 3', brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: 'Karhu', brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username: 'Pekka', password: 'Foobar1')
  end

  it 'when given, is registered to the beer and user who is signed in' do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:15)

    expect{
      click_button 'Create Rating'
    }.to change{Rating.count}.from(0).to 1
  end

  describe 'when there is some' do
    before :each do
      brewery = FactoryGirl.create :brewery
      beer = FactoryGirl.create :beer, brewery:brewery

      @ratings = [10, 25, 22, 33, 40]

      @ratings.each do |score|
        FactoryGirl.create :rating, score:score, beer:beer, user:user
      end

      visit ratings_path
    end

    it 'correct count is shown' do
      expect(page).to have_content "Number of ratings: #{@ratings.count}"
    end

    it 'correct ratings are shown' do
      expect(page).to have_content '10'
      expect(page).to have_content 'anonymous'
      expect(page).to have_content '33'
      expect(page).to have_content '40'
    end
  end
end