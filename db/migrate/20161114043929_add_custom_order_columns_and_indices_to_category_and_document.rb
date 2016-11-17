class AddCustomOrderColumnsAndIndicesToCategoryAndDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :custom_order, :int
    add_column :documents, :custom_order, :int
    add_index :categories, :custom_order
    add_index :documents, :custom_order
  end
end
