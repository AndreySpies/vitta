class CreatePatientRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_records do |t|
      t.string :entry
      t.references :patient, index: true, foreign_key: {to_table: :users}
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
