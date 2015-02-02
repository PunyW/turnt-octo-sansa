require 'rails_helper'

include OwnTestHelper

describe 'Beer' do
  let!(:user) { FactoryGirl.create :user }
  describe 'with signed in user' do
    before :each do
      sign_in(username: 'Pekka', password: 'Foobar1')
      visit beers_path
    end

    it 'should contain link to create new beer' do
      expect(page).to have_link 'New Beer'
    end

    describe 'when creating one' do
      let!(:brewery) { FactoryGirl.create :brewery, name: 'Koff' }
      before :each do
        visit new_beer_path
        select 'Koff', from:'beer[brewery_id]'
        select 'Lager', from:'beer[style]'
      end

      it 'should be created with correct information' do
        fill_in 'beer[name]', with:'iso 3'

        expect{
          click_button 'Create Beer'
        }.to change{Beer.count}.from(0).to 1

        expect(page).to have_content 'iso 3'
      end

      it 'should not be created with wrong information' do
        fill_in 'beer[name]', with:''

        click_button 'Create Beer'

        expect(page).to have_content "Name can't be blank"
        expect(Beer.count).to eq 0
      end
    end
  end

  it 'cannot create new beer without signing in' do
    expect(page).not_to have_link 'New Beer'
  end
end
