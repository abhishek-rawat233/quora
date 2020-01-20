class AddCustomerIdToBaseUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :base_users, :customer_id, :string
    add_index :base_users, :customer_id
  end
end
