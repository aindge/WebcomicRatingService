class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.string :author
      t.string :url
      t.string :synopsis
      t.string :genre
      t.float :rating_art, {:default=>0}
      t.float :rating_story, {:default=>0}
      t.float :rating_overall, {:default=>0}
      t.integer :rates, {:default=>0}

      t.timestamps
    end
  end
end
