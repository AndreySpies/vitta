class WorkSchedule < ApplicationRecord
  belongs_to :doctor
  has_many :work_days, dependent: :destroy
end
