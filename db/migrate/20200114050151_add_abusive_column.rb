class AddAbusiveColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :abusive, :boolean, default: false
    add_column :answers, :abusive, :boolean, default: false
  end
end
