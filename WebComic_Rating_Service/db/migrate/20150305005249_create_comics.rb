class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.string :author
      t.string :url
      t.string :synopsis
      t.string :genre
      t.float :rating_art
      t.float :rating_story
      t.float :rating_overall
      t.integer :rates

      t.timestamps
    end
  end
end
