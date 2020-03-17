class CreateTrying < ActiveRecord::Migration[6.0]
  def change
    create_table :tryings, id: false do |t|
      t.string :email, primary_key: true
    end
  end
end
