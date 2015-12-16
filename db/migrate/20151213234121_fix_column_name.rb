class FixColumnName < ActiveRecord::Migration
  def change 
    rename_column :stores, :increment, :timeincrement 
  end
end
