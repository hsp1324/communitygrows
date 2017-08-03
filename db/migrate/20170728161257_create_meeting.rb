class CreateMeeting < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
    	t.string :name
    	t.string :date
        t.string :time
    	t.string :location
    	t.string :description
    	t.string :agenda
    	t.string :hangout
    end
  end
end
