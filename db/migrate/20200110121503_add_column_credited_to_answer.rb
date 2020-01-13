class AddColumnCreditedToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :is_point_credited, :boolean, default: false
  end
end
