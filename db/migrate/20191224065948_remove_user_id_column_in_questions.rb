class RemoveUserIdColumnInQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :base_user_id
  end
end
