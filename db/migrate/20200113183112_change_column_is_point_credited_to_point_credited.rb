class ChangeColumnIsPointCreditedToPointCredited < ActiveRecord::Migration[6.0]
  def change
    rename_column :answers, :is_point_credited, :point_credited
  end
end
