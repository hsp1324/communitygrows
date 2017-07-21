class CreateCommitee < ActiveRecord::Migration[5.0]
  def change
    create_table :commitees do |t|
    	t.string :name
    end
  end
end
