class CreateWorkDays < ActiveRecord::Migration[5.2]
  def change
    create_table :work_days do |t|
      t.integer :day
      t.references :work_schedule, foreign_key: true

      t.timestamps
    end
  end
end
