class CreateWorkSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :work_schedules do |t|
      t.references :doctor, foreign_key: true
      t.timestamps
    end
  end
end
