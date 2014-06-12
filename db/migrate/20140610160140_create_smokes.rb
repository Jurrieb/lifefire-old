class CreateSmokes < ActiveRecord::Migration
  def change
    create_table :smokes do |t|
      t.integer :user_id
      t.date :date
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
