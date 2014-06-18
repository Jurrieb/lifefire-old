class CreateUserSmokeAddictions < ActiveRecord::Migration
  def change
    create_table :user_smoke_addictions do |t|
      t.integer :user_id
      t.integer :avarage_smokes_day

      t.timestamps
    end
  end
end
