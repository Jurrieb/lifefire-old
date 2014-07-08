class AddColumnUserHashToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_hash, :string
  end
end
