class CreateDoctorSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :doctor_schedules do |t|
      t.references :doctor, foreign_key: true
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end
