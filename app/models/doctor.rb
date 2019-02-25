class Doctor < ApplicationRecord
  belongs_to :user
  has_many :specialties, through: :doctor_specialties
end
