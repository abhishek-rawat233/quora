class ChangeColumnTypeInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :verified, :boolean, default: false
  end
end
