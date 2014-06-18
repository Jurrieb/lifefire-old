class AddColumnProfileToUserPreference < ActiveRecord::Migration
  def change
    add_column :user_preferences, :profile, :boolean, default: false
  end
end
