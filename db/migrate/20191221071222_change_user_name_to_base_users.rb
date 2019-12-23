class ChangeUserNameToBaseUsers < ActiveRecord::Migration[6.0]
  def change
    rename_table :users, :base_users
  end
end
