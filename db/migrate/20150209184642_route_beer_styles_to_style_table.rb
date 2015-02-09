class RouteBeerStylesToStyleTable < ActiveRecord::Migration
  def change
    rename_column :beers, :style, :old_style
    add_column :beers, :style_id, :integer
    create_styles
    join_new_styles_to_beers
    remove_column :beers, :old_style, :string
  end


  def create_styles
    reversible do |change|
      change.up do
        Beer.all.group(:old_style).each do |beer|
          Style.create name: beer.old_style, description:'WIP'
        end
      end

      change.down do
        Beer.all.group(:old_style).each do |beer|
          Style.find_by_name(beer.old_style).delete
        end
      end
    end

  end

  def join_new_styles_to_beers
    reversible do |change|
      change.up do
        Beer.all.each do |beer|
          beer.style = Style.find_by_name beer.old_style
          beer.save
        end
      end

      change.down do
        Beer.all.each do |beer|
          beer.old_style = beer.style.name
          beer.save
        end
      end
    end

  end

end
