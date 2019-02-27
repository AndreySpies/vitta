class Doctor < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :doctor_specialties, dependent: :destroy
  has_many :specialties, through: :doctor_specialties, dependent: :destroy
  monetize :price_cents
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
