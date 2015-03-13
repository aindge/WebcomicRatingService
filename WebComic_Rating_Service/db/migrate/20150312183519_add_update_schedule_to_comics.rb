class AddUpdateScheduleToComics < ActiveRecord::Migration
  def change
    add_column :comics, :update_schedule, :string
  end
end
