class CreatePopulairSports < ActiveRecord::Migration
  def change
    create_table :populair_sports do |t|
      t.string :name
      t.integer :kcal
      t.timestamps
    end
  end
end
