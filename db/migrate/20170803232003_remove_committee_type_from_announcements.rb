class RemoveCommitteeTypeFromAnnouncements < ActiveRecord::Migration[5.1]
  def change
    remove_column :announcements, :committee_type, :string
  end
end
