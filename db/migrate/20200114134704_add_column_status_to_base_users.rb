class AddColumnStatusToBaseUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :base_users, :status, :integer, default: 0
  end
end
