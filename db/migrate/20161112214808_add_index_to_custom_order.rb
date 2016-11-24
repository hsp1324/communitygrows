class AddIndexToCustomOrder < ActiveRecord::Migration[5.0]
  def change
  	add_index :categories, :custom_order
  	add_index :documents, :custom_order
  end
end
