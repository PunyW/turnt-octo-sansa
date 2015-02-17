module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if self.ratings.nil? || self.ratings.count.equal?(0)
    self.ratings.average(:score).truncate(1)
  end
end