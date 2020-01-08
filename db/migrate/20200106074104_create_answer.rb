class CreateAnswer < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :base_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
