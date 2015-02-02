require 'rails_helper'

include OwnTestHelper

describe 'User' do
  describe 'who has signed up' do
    before :each do
      @user = FactoryGirl.create :user
    end

    it 'can sign in with right credentials' do
      sign_in(username: 'Pekka', password: 'Foobar1')

      expect(page).to have_content 'Welcome back Pekka!'
      expect(page).to have_content 'Pekka'
    end

    it 'is redirected back to sign in form if wrong credentials given' do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'wrong')
      click_button('Log in')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username or password mismatch'
    end

    describe 'viewing own user page' do
      before :each do
        sign_in(username: 'Pekka', password: 'Foobar1')
        visit user_path @user
      end

      it 'initially should not have ratings' do
        expect(page).to have_content 'Rated 0 beers'
      end

      describe 'after rating some beers' do
        before :each do
          @beers = ['iso 3', 'Karhu', 'Tuplahumala']
          score = 25
          @beers.each do |beer_name|
            @beer = FactoryGirl.create :beer, name:beer_name
            create_rating score += 5, @beer, @user
          end

          other_user = FactoryGirl.create :user, username:'test'
          create_rating 24, @beer, other_user

          visit user_path @user
        end

        it 'should show own ratings' do
          expect(page).to have_content "Rated #{@beers.count} beers"

          @beers.each do |beer_name|
            expect(page).to have_content beer_name
          end
        end

        it 'should not have ratings from other users' do
          expect(page).not_to have_content '24'
        end

        it 'removing rating should remove it from database' do
          find_by_id('rating1').click
          expect(page).not_to have_content 'iso 3'
          expect(page).to have_content "Rated #{@beers.count - 1} beers"
        end

        it 'should have users favorite beer' do
          expect(page).to have_content 'favorite beer Tuplahumala'
        end

        it 'should have users favorite style' do
          expect(page).to have_content 'Favorite style Lager'
        end

        it 'should have users favorite brewery' do
          expect(page).to have_content 'Favorite brewery anonymous'
        end
      end
    end
  end

  it 'when signed up with good credentials, is added to the system' do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Foobar1')
    fill_in('user_password_confirmation', with:'Foobar1')

    expect{
      click_button 'Create User'
    }.to change{User.count}.by 1
  end



end