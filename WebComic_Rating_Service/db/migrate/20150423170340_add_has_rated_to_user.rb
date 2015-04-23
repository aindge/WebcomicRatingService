class AddHasRatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :has_rated, :string
  end
end
