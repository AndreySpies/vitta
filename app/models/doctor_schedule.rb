class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :schedule
end
