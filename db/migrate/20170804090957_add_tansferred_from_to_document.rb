class AddTansferredFromToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :transferred_from, :string 
  end
end
