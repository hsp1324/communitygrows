class AddInfoToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :title
      t.string :committee
      t.text :about_me 
      t.text :why_join
      t.text :interests_skills
end
  end
end
