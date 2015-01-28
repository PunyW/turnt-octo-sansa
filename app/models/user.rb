class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password



  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }
  validates :password, allow_nil: true, :format => {with: /((?=.*\d)(?=.*[A-Z]).{4,})/, message: 'must be at least 4 characters long and include one uppercase letter and one number' }
end
