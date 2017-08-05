class AddAssociationsToMailRecords < ActiveRecord::Migration[5.1]
  def change
    add_reference :mail_records, :committee, foreign_key: true
    add_reference :mail_records, :category, foreign_key: true
    add_reference :mail_records, :user, foreign_key: true
    add_reference :mail_records, :announcement, foreign_key: true
    add_reference :mail_records, :document, foreign_key: true
    add_reference :mail_records, :meeting, foreign_key: true
  end
end
