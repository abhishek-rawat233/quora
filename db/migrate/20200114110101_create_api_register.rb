class CreateApiRegister < ActiveRecord::Migration[6.0]
  def change
    create_table :api_registers do |t|
      t.references :base_user, null: true, foreign_key: true
      t.integer :api_type, null: false
      t.string :url, null: false
      t.string :ip_address

      t.timestamps
    end
  end
end
