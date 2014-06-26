class RenameCountToCounterSmokes < ActiveRecord::Migration
  def change
    rename_column :smokes, :count, :counted
  end
end
