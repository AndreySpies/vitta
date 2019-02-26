class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :doctor, dependent: :destroy
  has_many :consultations, class_name: 'Consultation', foreign_key: 'patient_id'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
