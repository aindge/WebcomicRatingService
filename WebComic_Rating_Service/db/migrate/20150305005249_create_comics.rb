class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.string :author
      t.string :url
      t.string :synopsis
      t.string :genre
      t.integer :rating_art
      t.integer :rating_story
      t.integer :rating_overall

      t.timestamps
    end
  end
end
