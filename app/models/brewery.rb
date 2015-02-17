class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true, allow_blank: false
  validates :year, presence: true, allow_blank: false,
            numericality: {only_integer: true},
            :inclusion => { :in => proc {1042..Date.today.year},
                            :message => proc {"must be between 1042 and #{Date.today.year}"} }

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by { |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take(n)
  end
end
