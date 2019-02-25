class Doctor < ApplicationRecord
  belongs_to :user
  has_many :consultations
  has_many :doctor_specialties
  has_many :specialties, through: :doctor_specialties
  monetize :price_cents
end
