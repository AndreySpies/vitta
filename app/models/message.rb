class Message < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
end
