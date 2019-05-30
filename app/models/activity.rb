class Activity < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  has_many :bookings
  mount_uploader :photo, PhotoUploader
  validates :name, :address, :type_activity, :price, :description, presence: true
  validates :max_participants, :seller, presence: true
  validates :price, :max_participants, numericality: { only_integer: true }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch

  pg_search_scope :search_by_name_and_address_and_type_activity,
    against: [:name, :address, :type_activity],
    using: {
      tsearch: { prefix: true }
    }
end
