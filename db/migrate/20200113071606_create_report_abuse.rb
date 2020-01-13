class CreateReportAbuse < ActiveRecord::Migration[6.0]
  def change
    create_table :report_abuses do |t|
      t.references :base_user, null: false, foreign_key: true
      t.references :abusable, polymorphic: true

      t.timestamps
    end
  end
end
