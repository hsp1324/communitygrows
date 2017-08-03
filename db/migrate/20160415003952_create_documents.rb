class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :url
      t.string :title
      t.timestamps null: false
      t.string :committee_type
    end
  end
end
