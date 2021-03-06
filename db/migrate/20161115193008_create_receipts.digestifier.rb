# This migration comes from digestifier (originally 1)
class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :digestifier_receipts do |t|
      t.string   :recipient_type, null: false
      t.integer  :recipient_id,   null: false
      t.datetime :captured_at,    null: false
    end

    add_index :digestifier_receipts, [:recipient_type, :recipient_id],
      unique: true
  end
end
