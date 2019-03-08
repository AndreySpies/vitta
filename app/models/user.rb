class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :profile_picture, PhotoUploader
  has_one :admin
  has_one :doctor, dependent: :destroy
  has_one :medical_record, dependent: :destroy
  has_many :reviews
  has_many :orders, class_name: 'Order', foreign_key: 'patient_id'
  has_many :consultations, class_name: 'Consultation', foreign_key: 'patient_id'
  has_many :patient_record, class_name: 'PatientRecord', foreign_key: 'patient_id'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :phone, presence: true, format: { with: /\A\d{2}9\d{8}\z/, message: 'deve possuir código de área e ser digitado sem espaços ou traços'}, uniqueness: true
  validates :birth_date, presence: true

  after_create :create_medical_record

  private

  def create_medical_record
    MedicalRecord.create!(user: self)
  end
end
