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

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    Style.find_by id: (average_of 'style_id')
  end

  def favorite_brewery
    return nil if ratings.empty?
    Brewery.find_by id: (average_of 'brewery_id')
  end

  def average_of(column)
    Rating.joins(:beer).group(column).calculate(:average, :score).sort_by { |average| average[1]}.reverse!.first[0]
  end
end
