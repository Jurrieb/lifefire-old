class ChangeProfileColumns < ActiveRecord::Migration
  def change
    add_column :user_preferences, :private_profile, :boolean, default: true
    rename_column :user_preferences, :profile, :public_profile
    change_column :user_preferences, :public_profile,  :boolean, default: true
  end
end
