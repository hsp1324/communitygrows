class RemoveGeneralCategoryFromDocuments < ActiveRecord::Migration[5.0]
  def change
    remove_column :documents, :general_category, :string
  end
end
