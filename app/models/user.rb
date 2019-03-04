class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :profile_picture, PhotoUploader
  has_one :doctor, dependent: :destroy
  has_one :medical_record, dependent: :destroy
  has_many :reviews
  has_many :consultations, class_name: 'Consultation', foreign_key: 'patient_id'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :rg, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :birth_date, presence: true

  after_create :create_medical_record

  private

  def create_medical_record
    MedicalRecord.create!(user: self)
  end
end
