class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.integer :user_id
      t.integer :populair_sport_id
      t.date :date
      t.integer :duration
      t.integer :distance

      t.timestamps
    end
  end
end
