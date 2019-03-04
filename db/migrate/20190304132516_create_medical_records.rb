class CreateMedicalRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_records do |t|
      t.references :user, foreign_key: true
      t.string :blood
      t.text :allergies

      t.timestamps
    end
  end
end
