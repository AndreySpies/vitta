class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :method
      t.references :consultation, foreign_key: true
      t.references :doctor, foreign_key: true
      t.references :patient, index: true, foreign_key: {to_table: :users}
      t.string :consultation_start_time
      t.string :consultation_end_time

      t.timestamps
    end
  end
end
