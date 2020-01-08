class CreateComment < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :base_user, null: false, foreign_key: true
      t.references :commentable, polymorphic: true

      t.timestamps
    end
  end
end
