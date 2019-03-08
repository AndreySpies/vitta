class WorkDay < ApplicationRecord
  belongs_to :work_schedule
  validates :day, uniqueness: true, numericality: { only_integer: true }, inclusion: { in: (0..6).to_a}
end
