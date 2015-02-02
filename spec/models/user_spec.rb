require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has the username set correctly' do
    BeerClub
    BeerClubsController
    user = User.new username:'Pekka'

    expect(user.username.to_s).to eq 'Pekka'
  end

  it 'is not saved without a password' do
    user = User.create username:'Pekka'

    expect(user.valid?).to be false
    expect(User.count).to eq 0
  end

  describe 'favorite style' do
    let(:user){ FactoryGirl.create :user}

    it 'has method for determining one' do
      expect(user).to respond_to :favorite_style
    end

    it 'without ratings does not have one' do
      expect(user.favorite_style).to eq nil
    end

    it 'is the only style rated if only one rating' do
      beer = FactoryGirl.create :beer
      FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style).to eq beer.style
    end

    it 'is the one with highest rating if several styles rated' do
      fav_style = 'IPA'
      create_beers_with_ratings(10, 10, 10, user)
      create_beers_with_ratings_and_style(20, 20, 20, fav_style, user)

      expect(user.favorite_style).to eq fav_style
    end
  end

  describe 'favorite brewery' do
    let(:user){ FactoryGirl.create :user}

    it 'has method for determining one' do
      expect(user).to respond_to :favorite_brewery
    end

    it 'without ratings does not have one' do
      expect(user.favorite_brewery).to eq nil
    end

    it 'is the only one with ratings' do
      brewery = create_brewery_with_rating(10, user)
      expect(user.favorite_brewery).to eq brewery
    end

    it 'is the one with highest rating if several rated' do
      brewery1 = create_brewery_with_rating(2, user)
      create_ratings_for_brewery(2, 10, 22, 1, brewery1, user)
      brewery = create_brewery_with_rating(40, user)
      create_ratings_for_brewery(22, 47, 25, brewery, user)

      expect(user.favorite_brewery).to eq brewery
    end
  end

  describe 'favorite beer' do
    let(:user){ FactoryGirl.create :user}

    it 'has method for determining one' do
      expect(user).to respond_to :favorite_beer
    end

    it 'without ratings does not have one' do
      expect(user.favorite_beer).to eq nil
    end

    it 'is the only rated if only one rating' do
      beer = FactoryGirl.create :beer
      FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq beer
    end

    it 'is the one with highest rating if several rated' do
      create_beers_with_ratings(10, 19, 8, 15, 22, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end


  describe 'with a proper password' do
    let(:user){ FactoryGirl.create :user }

    it 'is is saved' do
      expect(user.valid?).to be true
      expect(User.count).to eq 1
    end

    it 'and with two ratings, has the correct average rating' do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq 2
      expect(user.average_rating).to eq 15.0
    end
  end

  describe 'with invalid password' do
    let(:user){ User.new username:'Pekka' }
    it 'where password contains only letters is not saved' do
      user.password = user.password_confirmation = 'Secret'
      user.save

      expect(user.valid?).to be false
      expect(User.count).to eq 0
    end

    it 'and where password is too short is not saved' do
      user.password = user.password_confirmation = 'Se1'
      user.save

      expect(user.valid?).to be false
      expect(User.count).to eq 0
    end
  end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create :beer
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  def create_beers_with_ratings_and_style(*scores, style, user)
    scores.each do |score|
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    end
  end

  def create_brewery_with_rating(score, user)
    brewery = FactoryGirl.create :brewery
    beer = FactoryGirl.create(:beer, brewery:brewery)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    brewery
  end

  def create_ratings_for_brewery(*scores, brewery, user)
    scores.each do |score|
      beer = FactoryGirl.create(:beer, brewery:brewery)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    end
  end

end
