class Doctor < ApplicationRecord
  belongs_to :user
  has_many :doctor_specialties
  has_many :specialties, through: :doctor_specialties
end
