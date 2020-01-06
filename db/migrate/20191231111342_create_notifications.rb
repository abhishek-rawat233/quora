class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :base_user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
    end
  end
end
