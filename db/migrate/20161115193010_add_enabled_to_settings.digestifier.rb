# This migration comes from digestifier (originally 3)
class AddEnabledToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :digestifier_settings, :enabled, :boolean, default: true,
      null: false
    Digestifier::Setting.reset_column_information
  end
end
