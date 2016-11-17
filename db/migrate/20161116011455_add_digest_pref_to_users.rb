class AddDigestPrefToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :digest_pref, :string
  end
end
