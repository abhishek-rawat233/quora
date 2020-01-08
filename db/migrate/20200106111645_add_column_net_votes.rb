class AddColumnNetVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :netvotes, :integer, default: 0

    add_column :questions, :netvotes, :integer, default: 0

    add_column :comments, :netvotes, :integer, default: 0
  end
end
