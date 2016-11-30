class AddTiltedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tilted, :boolean
  end
end
