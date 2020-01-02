class ChangeColumnNameInBaseUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :base_users, :remember_login_token, :api_token 
  end
end
