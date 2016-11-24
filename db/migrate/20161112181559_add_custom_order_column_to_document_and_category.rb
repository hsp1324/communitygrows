class AddCustomOrderColumnToDocumentAndCategory < ActiveRecord::Migration[5.0]
  def change
  	add_column :categories, :custom_order, :int
  	add_column :documents, :custom_order, :int
  end
end
