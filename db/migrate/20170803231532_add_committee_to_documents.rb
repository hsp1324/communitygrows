class AddCommitteeToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_reference :documents, :committee, foreign_key: true
  end
end
