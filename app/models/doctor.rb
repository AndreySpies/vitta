class Doctor < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :doctor_specialties, dependent: :destroy
  has_many :specialties, through: :doctor_specialties, dependent: :destroy
  has_many :doctor_schedules, dependent: :destroy
  has_many :schedules, through: :doctor_schedules, dependent: :destroy
  monetize :price_cents
end
