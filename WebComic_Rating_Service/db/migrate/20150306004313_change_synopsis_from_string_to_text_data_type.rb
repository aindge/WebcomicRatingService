class ChangeSynopsisFromStringToTextDataType < ActiveRecord::Migration
  def change
  	change_column :comics, :synopsis, :text
  end
end
