class Consultation < ApplicationRecord
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :doctor
  has_one :order
end
