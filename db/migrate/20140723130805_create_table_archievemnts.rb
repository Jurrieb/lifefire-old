class CreateTableArchievemnts < ActiveRecord::Migration
  def change
    create_table :archievemnts do |t|
      t.integer :user_id
      t.integer :code
      t.timestamps
    end
  end
end
