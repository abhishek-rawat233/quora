class AddPrimaryKeyToQuestionsTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :questions_topics, :id, :primary_key
  end
end
