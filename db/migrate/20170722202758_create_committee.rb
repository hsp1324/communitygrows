class CreateCommittee < ActiveRecord::Migration[5.0]
  def change
    create_table :committees do |t|
      t.string :name
      t.boolean :hidden
      t.boolean :inactive
    end
  end
end
