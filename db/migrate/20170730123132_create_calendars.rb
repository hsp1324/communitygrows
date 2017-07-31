class CreateCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :link
      t.boolean :hidden

      t.timestamps
    end
  end
end
