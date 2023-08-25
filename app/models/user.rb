class User < ApplicationRecord
  has_many :places, dependent: :destroy
  has_many :bookings, dependent: :destroy
  # has_many :received_bookings, source: 'Booking'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true

  def received_bookings
    self.places.map(&:bookings).flatten
  end
end
