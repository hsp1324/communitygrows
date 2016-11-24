class AddRaceGenderUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ethnicity, :text
    add_column :users, :gender, :text
    remove_column :users, :interests_skills, :text
  end
end
