class AddDescriptionToMailRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :mail_records, :description, :string
  end
end
