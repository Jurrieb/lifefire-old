class RenameKaramapointsToKarma < ActiveRecord::Migration
  def change
    rename_column :users, :karmapoints, :karma
  end
end
