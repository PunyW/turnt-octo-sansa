class RouteBeerStylesToStyleTable < ActiveRecord::Migration
  def change
    create_styles
    rename_column :beers, :style, :old_style
    add_column :beers, :style, :string
    join_new_styles_to_beers
    remove_column :beers, :old_style, :string
    add_column :styles, :beer_id, :integer
  end


  def create_styles
    reversible do |change|
      change.up do
        Beer.all.group('style').each do |beer|
          Style.create name: beer.name, description:'WIP'
        end
      end

      change.down do
        Beer.all.group('style').each do |beer|
          Style.find_by_name(beer.name).delete
        end
      end
    end

  end

  def join_new_styles_to_beers
    reversible do |change|
      change.up do
        Beer.all.each do |beer|
          beer.style = beer.old_style
          beer.save
        end
      end

      change.down do
        Beer.all.each do |beer|
          beer.old_style = beer.style
          beer.save
        end
      end
    end

  end

end
