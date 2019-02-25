class CreateConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :consultations do |t|
      t.references :patient, index: true, foreign_key: {to_table: :users}
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
