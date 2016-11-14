class CreateReadSession < ActiveRecord::Migration
  def change
    create_table :read_sessions do |t|
      t.references :user
      t.references :document
    end
  end
end
