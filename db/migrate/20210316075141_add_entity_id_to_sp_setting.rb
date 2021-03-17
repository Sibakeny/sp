class AddEntityIdToSpSetting < ActiveRecord::Migration[6.1]
  def change
    add_column :sp_settings, :entity_id, :string
  end
end
