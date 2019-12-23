class ChangeInterestsNameToUserFavoriteTopics < ActiveRecord::Migration[6.0]
  def change
    rename_table :interests, :user_favorite_topics
  end
end
