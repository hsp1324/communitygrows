class AddCommitteeTypeToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :committee_type, :string
  end
end
