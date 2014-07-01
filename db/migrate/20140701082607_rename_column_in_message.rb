class RenameColumnInMessage < ActiveRecord::Migration
  def change
    rename_column :messages, :name, :message
  end
end
