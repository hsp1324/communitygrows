class CreateDocuments < ActiveRecord::Migration[4.2]
  def change
    create_table :documents do |t|
      t.string :url
      t.string :title
      t.timestamps null: false
      t.string :committee_type
    end
  end
end
