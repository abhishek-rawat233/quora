class ChangeUserReference < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_favorite_topics, :user_id, :base_user_id
  end
end
