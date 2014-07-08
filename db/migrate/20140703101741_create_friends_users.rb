class CreateFriendsUsers < ActiveRecord::Migration
  def change
    create_table :friends_users, id: false do |t|
    	t.references :user
    	t.references :friend
    end
  end
end
