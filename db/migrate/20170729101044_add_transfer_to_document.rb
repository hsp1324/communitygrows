class AddTransferToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :transfer, :boolean, default: false 
  end
end
