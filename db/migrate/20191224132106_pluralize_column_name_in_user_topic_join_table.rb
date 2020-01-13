class PluralizeColumnNameInUserTopicJoinTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_favorite_topics, :topics_id, :topic_id
  end
end
