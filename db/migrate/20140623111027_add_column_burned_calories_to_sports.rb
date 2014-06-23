class AddColumnBurnedCaloriesToSports < ActiveRecord::Migration
  def change
    add_column :sports, :burned_calories, :integer, default: 0
  end
end
