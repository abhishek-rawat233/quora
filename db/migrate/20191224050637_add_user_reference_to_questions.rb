class AddUserReferenceToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :base_user, null: false, foreign_key: true
  end
end
