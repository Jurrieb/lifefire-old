class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.integer :user_id
      t.integer :height, default: 0
      t.integer :weight, default: 0
      t.integer :target_weight, default: 0

      t.timestamps
    end
  end
end
