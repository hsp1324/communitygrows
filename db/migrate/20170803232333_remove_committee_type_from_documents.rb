class RemoveCommitteeTypeFromDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :committee_type, :string
  end
end
