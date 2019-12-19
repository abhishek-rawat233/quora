class AddNameAndRememberTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :remember_login_token, :string
  end
end
