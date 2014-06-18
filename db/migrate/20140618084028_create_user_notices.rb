class CreateUserNotices < ActiveRecord::Migration
  def change
    create_table :user_notices do |t|
      t.integer :user_id
      t.boolean :mail
      t.boolean :daily_updates
      t.boolean :push_notice

      t.timestamps
    end
  end
end
