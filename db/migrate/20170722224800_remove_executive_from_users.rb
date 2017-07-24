class RemoveExecutiveFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :executive, :boolean
  end
end
