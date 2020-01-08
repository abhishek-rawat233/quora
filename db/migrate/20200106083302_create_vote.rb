class CreateVote < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :vote_type
      t.references :base_user, null: false, foreign_key: true
      t.references :voteable, polymorphic: true

      t.timestamps
    end
  end
end
