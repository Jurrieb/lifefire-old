class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
