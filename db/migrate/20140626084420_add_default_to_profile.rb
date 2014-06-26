class AddDefaultToProfile < ActiveRecord::Migration
  def change
    change_column :user_preferences, :profile, :boolean, default: false
  end
end
