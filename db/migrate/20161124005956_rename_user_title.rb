class RenameUserTitle < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :title, :board_role
    add_column :users, :current_company, :text
    add_column :users, :current_position, :text
  end
end
