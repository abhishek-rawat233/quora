class CreateTrainin < ActiveRecord::Migration[6.0]
  def change
    create_table :trainins do |t|
      t.references :base_user, null: true, foreign_key: true
      t.integer :ap, null: false
      t.string :ur, null: false
      t.string :ip_address

      t.timestamps
    end
  end
end
