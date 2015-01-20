module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    self.ratings.average(:score).truncate(2)
  end

end