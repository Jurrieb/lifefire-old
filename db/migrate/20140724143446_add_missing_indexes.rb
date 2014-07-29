class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :messages, :user_id
    add_index :friendships, [:user_id, :user_id]
    add_index :friendships, :user_id
    add_index :friendships, :friend_id
    add_index :achievements, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :user_id
    add_index :smokes, :user_id
    add_index :sports, :populair_sport_id
    add_index :sports, :user_id
    add_index :user_details, :user_id
    add_index :user_notices, :user_id
    add_index :user_preferences, :user_id
    add_index :user_profiles, :user_id
    add_index :user_smoke_addictions, :user_id
  end
end
