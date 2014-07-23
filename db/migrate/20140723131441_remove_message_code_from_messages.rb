class RemoveMessageCodeFromMessages < ActiveRecord::Migration
  def change
	remove_column :messages, :message_code
  end
end
