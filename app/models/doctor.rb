require 'json'
require 'open-uri'
require 'pagarme'

class Doctor < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :messages
  has_many :reviews, dependent: :destroy
  has_many :consultations, dependent: :destroy
  has_many :orders
  has_many :patient_record, dependent: :destroy
  has_many :doctor_specialties, dependent: :destroy
  has_many :specialties, through: :doctor_specialties, dependent: :destroy
  has_one :work_schedule, dependent: :destroy
  monetize :price_cents
  geocoded_by :address
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :crm, presence: true, uniqueness: true

  after_validation :set_coordinates, :create_bank_account, :create_recipient
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

  def create_bank_account
    PagarMe.api_key        = ENV["PAGARME_API_KEY"]
    PagarMe.encryption_key = ENV["PAGARME_ENCRYPTION_KEY"]

    bank_account = PagarMe::BankAccount.new({
                                              bank_code: self.bank_code,
                                              agencia: self.agency,
                                              agencia_dv: self.agency_vd,
                                              conta: self.account,
                                              conta_dv: self.account_vd,
                                              legal_name: "#{self.user.first_name} #{self.user.last_name}",
                                              document_number: '04499225027'
    })

    bank_account.create
    self.bank_account_id = bank_account.id
    self
  end

  def create_recipient
    PagarMe.api_key        = ENV["PAGARME_API_KEY"]
    PagarMe.encryption_key = ENV["PAGARME_ENCRYPTION_KEY"]

    recipient = PagarMe::Recipient.new({
                                         bank_account_id: self.bank_account_id.to_s,
                                         transfer_enabled: true,
                                         transfer_interval: "daily"
    }).create
    self.recipient_id = recipient.id
    self
  end
end
