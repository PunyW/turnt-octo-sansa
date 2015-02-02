module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_rating(score, beer, user)
    FactoryGirl.create :rating, score:score, beer:beer, user:user
  end
end