require 'json'
require 'open-uri'

class Doctor < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :consultations, dependent: :destroy
  has_many :orders
  has_many :patient_record
  has_many :doctor_specialties, dependent: :destroy
  has_many :specialties, through: :doctor_specialties, dependent: :destroy
  has_one :work_schedule, dependent: :destroy
  monetize :price_cents
  geocoded_by :address
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :crm, presence: true, uniqueness: true
  # after_validation :geocode, if: :will_save_change_to_address?
  after_validation :set_coordinates
  after_save :create_schedule
  pg_search_scope :global_search,
                  associated_against: {
                  user: [:first_name, :last_name],
                  specialties: [:name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  private

  def create_schedule
    WorkSchedule.create!(doctor: self)
  end

  def set_coordinates
    # self.description = "https://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}&key=#{ENV['GOOGLE_API_KEY']}"
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}&key=#{ENV['GOOGLE_API_KEY']}"
    api_response = open(URI.escape(url)).read
    coordinates = JSON.parse(api_response)
    # self.description = coordinates['results']
    self.latitude = coordinates["results"].first["geometry"]["location"]["lat"]
    self.longitude = coordinates["results"].first["geometry"]["location"]["lng"]
  end
end
