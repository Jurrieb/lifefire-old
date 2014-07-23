class ChangeComments < ActiveRecord::Migration
  def change
	remove_column :comments, :activity_id
	add_column :comments, :message_id, :integer
  end
end
