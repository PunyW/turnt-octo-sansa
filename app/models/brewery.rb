class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true, allow_blank: false
  validates :year, presence: true, allow_blank: false,
            numericality: {only_integer: true},
            :inclusion => { :in => proc {1042..Date.today.year},
                            :message => proc {"must be between 1042 and #{Date.today.year}"} }



end
