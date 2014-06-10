class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :karmapoints, :integer, default: 0
  end
end
