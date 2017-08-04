class RemoveOutdatedReferencesInMailRecords < ActiveRecord::Migration[5.1]
  def change
    remove_column :mail_records, :record_type, :string
    remove_column :mail_records, :record_id, :integer
    remove_column :mail_records, :commitee, :string
  end
end
