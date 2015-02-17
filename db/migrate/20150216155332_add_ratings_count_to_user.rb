class AddRatingsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :ratings_count, :integer, :default => 0

    User.reset_column_information
    User.all.each do |u|
      User.reset_counters u.id, :ratings
    end
  end
end
