class AddGeneralCategoryToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :general_category, :string
  end
end
