class Order < ApplicationRecord
  belongs_to :consultation, required: false
  belongs_to :doctor
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
end
