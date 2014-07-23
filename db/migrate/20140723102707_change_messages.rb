class ChangeMessages < ActiveRecord::Migration
  def change
    add_column :messages, :friend_id, :integer
    add_column :messages, :message_code, :integer
  end
end
