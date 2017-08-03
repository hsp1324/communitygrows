class AddCategoryIdToDocument < ActiveRecord::Migration[5.0]
  def change
  	add_column :documents, :category_id, :integer
  end
end
