class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
      t.integer :user_id
      t.boolean :smokes, default: false
      t.boolean :sports, default: false

      t.timestamps
    end
  end
end
