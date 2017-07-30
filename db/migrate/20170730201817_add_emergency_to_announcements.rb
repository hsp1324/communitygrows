class AddEmergencyToAnnouncements < ActiveRecord::Migration[5.0]
  def change
    add_column :announcements, :emergency, :boolean
  end
end
