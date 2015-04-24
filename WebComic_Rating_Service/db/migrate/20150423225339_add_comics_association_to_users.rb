class AddComicsAssociationToUsers < ActiveRecord::Migration
  def self.up
      add_column :comics, :user_id, :integer
      add_index 'comics', ['user_id'], :name => 'index_user_comic_id' 
  end

  def self.down
      remove_column :comics, :user_id
  end
end
