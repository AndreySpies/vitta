class Doctor < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :doctor_specialties, dependent: :destroy
  has_many :specialties, through: :doctor_specialties, dependent: :destroy
  monetize :price_cents
  geocoded_by :address
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :crm, presence: true, uniqueness: true
  after_validation :geocode, if: :will_save_change_to_address?

  pg_search_scope :global_search,
                  associated_against: {
                  user: [ :first_name, :last_name ],
                  specialties: [:name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
