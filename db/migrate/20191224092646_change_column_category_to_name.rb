class ChangeColumnCategoryToName < ActiveRecord::Migration[6.0]
  def change
    rename_column :topics, :category, :name
  end
end
