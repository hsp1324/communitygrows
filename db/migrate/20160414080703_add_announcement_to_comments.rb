class AddAnnouncementToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :announcement, index: true, foreign_key: true
  end
end
