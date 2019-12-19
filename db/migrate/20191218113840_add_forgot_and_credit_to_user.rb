class AddForgotAndCreditToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :forgot_password_token, :string
    add_column :users, :credits, :integer
  end
end
