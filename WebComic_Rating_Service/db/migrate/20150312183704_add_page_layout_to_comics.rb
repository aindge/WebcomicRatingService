class AddPageLayoutToComics < ActiveRecord::Migration
  def change
    add_column :comics, :page_layout, :string
  end
end
