class CreateFollow < ActiveRecord::Migration[6.0]
  def change
    create_table :follows, force: :cascade do |t|
      t.integer 'base_user_id'
      t.integer 'following_id'

      t.timestamps
    end
  end
end
