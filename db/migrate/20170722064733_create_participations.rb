class CreateParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :committee_id
      t.datetime :joined_at

      t.timestamps
    end
  end
end
