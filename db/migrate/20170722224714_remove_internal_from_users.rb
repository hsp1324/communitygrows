class RemoveInternalFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :internal, :boolean
  end
end
