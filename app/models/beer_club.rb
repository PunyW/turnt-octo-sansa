class BeerClub < ActiveRecord::Base
  has_many :memberships, -> { where confirmed: true }
  has_many :confirmation_requests, -> { where confirmed: false }, class_name: 'Membership'
  has_many :users, through: :memberships

  def to_s
    "#{name} from #{city}"
  end
end
