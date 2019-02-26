class Schedule < ApplicationRecord
  has_many :doctor_schedules, dependent: :destroy
  has_many :doctors, through: :doctor_schedules, dependent: :destroy
end
