class ChangeProfileColumns < ActiveRecord::Migration
  def change
    add_column :user_preferences, :private_profile, :boolean, default: false
    rename_column :user_preferences, :profile, :public_profile
  end
end
