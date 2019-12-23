class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :content
      t.integer :question_type

      t.timestamps
    end
  end
end
