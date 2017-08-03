class CreateComments < ActiveRecord::Migration[5.0]
  def self.up
    create_table :comments do |t|
      t.references :parent
      t.string :title
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
