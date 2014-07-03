class SetDefaultToAvarageSmokesDay < ActiveRecord::Migration
  def change
    change_column :user_smoke_addictions, :avarage_smokes_day, :integer, default: 0
  end
end
