class CreateExpertises < ActiveRecord::Migration[5.0]
  def change
    create_table :expertises do |t|
      t.boolean :constituency
      t.string  :name
    end
  end
end
