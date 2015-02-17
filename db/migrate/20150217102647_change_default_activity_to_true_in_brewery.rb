class ChangeDefaultActivityToTrueInBrewery < ActiveRecord::Migration
  def change
    change_column_default :breweries, :active, true
  end
end
