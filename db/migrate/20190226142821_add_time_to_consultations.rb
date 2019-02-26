class AddTimeToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :start_time, :datetime
    add_column :consultations, :end_time, :datetime
  end
end
