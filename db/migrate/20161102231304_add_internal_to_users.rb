class AddInternalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :internal, :boolean
  end
end
