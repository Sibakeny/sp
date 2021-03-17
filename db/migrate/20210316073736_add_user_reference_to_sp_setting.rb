class AddUserReferenceToSpSetting < ActiveRecord::Migration[6.1]
  def change
    add_reference :sp_settings, :user
  end
end
