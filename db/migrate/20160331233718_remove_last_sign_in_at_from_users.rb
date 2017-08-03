class RemoveLastSignInAtFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :last_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime, :default => Time.now, :null => false
  end
end
