class SetDefaultOnTableNotice < ActiveRecord::Migration
  def change
    change_column :user_notices, :mail, :boolean, default: false
    change_column :user_notices, :daily_updates, :boolean, default: false
    change_column :user_notices, :push_notice, :boolean, default: false
  end
end
