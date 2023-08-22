class Place < ApplicationRecord
  belongs_to :user
  has_many :bookings, through: :user
  has_many_attached :photos
end
