class AddHideColumnToCategory < ActiveRecord::Migration[5.0]
  def change
  	add_column :categories, :hidden, :boolean
  end
end
