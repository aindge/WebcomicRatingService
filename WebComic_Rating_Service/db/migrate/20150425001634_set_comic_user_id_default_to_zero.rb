class SetComicUserIdDefaultToZero < ActiveRecord::Migration
  def self.up
		change_column :comics, :user_id, :integer, :default => 0
  end
	def self.down
		change_column :comics, :user_id, :integer, :default => nil
  end
end
