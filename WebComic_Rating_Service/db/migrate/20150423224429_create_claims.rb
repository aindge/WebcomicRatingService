class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.integer :comic_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
