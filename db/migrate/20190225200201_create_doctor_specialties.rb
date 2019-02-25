class CreateDoctorSpecialties < ActiveRecord::Migration[5.2]
  def change
    create_table :doctor_specialties do |t|
      t.references :specialty, foreign_key: true
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
