class AddRate < ActiveRecord::Migration
  def change
	add_column :comics, :rates, :integer
	change_column :comics, :rating_art, :float
	change_column :comics, :rating_story, :float
	change_column :comics, :rating_overall, :float
  end
end
