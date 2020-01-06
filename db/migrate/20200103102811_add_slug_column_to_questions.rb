class AddSlugColumnToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :url_slug, :string, null: false
  end
end
