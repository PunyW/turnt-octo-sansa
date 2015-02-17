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

  def top_rating_of(column)
    return nil if ratings.empty?
    Rating.joins(:beer).group(column + '_id').calculate(:average, :score).sort_by { |average| average[1]}.reverse!.first[0]
  end

  def self.top_most_ratings(n)
    User.order(ratings_count: :desc).limit(n)
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite_style
    favorite :style
  end

  def rated(category)
    ratings.map{ |r| r.beer.send(category) }.uniq
  end

  def rating_of(category, item)
    ratings_of_item = ratings.select do |r|
      r.beer.send(category) == item
    end
    ratings_of_item.map(&:score).sum / ratings_of_item.count
  end

  def favorite(category)
    return nil if ratings.empty?

    category_ratings = rated(category).inject([]) do |set, item|
      set << {
          item: item,
          rating: rating_of(category, item)
      }
    end

    category_ratings.sort_by { |item| item[:rating] }.last[:item]
  end

end
