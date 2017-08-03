# This migration comes from digestifier (originally 2)
class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :digestifier_settings do |t|
      t.string  :recipient_type, null: false
      t.integer :recipient_id,   null: false
      t.text    :preferences,    null: false, default: '{}'
      t.timestamps               null: false
    end

    add_index :digestifier_settings, [:recipient_type, :recipient_id],
      unique: true
  end
end
