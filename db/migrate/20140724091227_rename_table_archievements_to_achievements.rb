class RenameTableArchievementsToAchievements < ActiveRecord::Migration
  def change
  	rename_table :archievemnts, :achievements
  end
end
