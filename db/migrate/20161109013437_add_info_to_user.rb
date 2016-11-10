class AddInfoToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :title
      t.string :committee
      t.text :about_me, :limit => 4294967295
      t.text :why_join, :limit => 4294967295
      t.text :interests_skills, :limit => 4294967295
end
  end
end
