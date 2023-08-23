class Place < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :price, numericality: true
  validates :price, numericality: { greater_than: 0 }
end
