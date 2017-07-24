class RemoveExternalFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :external, :boolean
  end
end
