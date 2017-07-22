class CreateMailRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :mail_records do |t|
      t.string :record_type
      t.integer :record_id
      t.string :committee , default: ''

      t.timestamps
    end
  end
end
