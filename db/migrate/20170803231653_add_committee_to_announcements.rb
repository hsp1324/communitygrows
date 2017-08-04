class AddCommitteeToAnnouncements < ActiveRecord::Migration[5.1]
  def change
    add_reference :announcements, :committee, foreign_key: true
  end
end
