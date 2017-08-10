class AddColorToCalendar < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :color, :string
  end
end
