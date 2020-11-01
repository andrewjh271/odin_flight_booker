# == Schema Information
#
# Table name: bookings
#
#  id         :bigint           not null, primary key
#  flight_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passenger_bookings, dependent: :destroy
  has_many :passengers, through: :passenger_bookings

  accepts_nested_attributes_for :passengers

  before_validation :find_or_create_passenger

  private

  def find_or_create_passenger
    # byebug
      self.passengers = self.passengers.map do |passenger|
        Passenger.find_or_create_by(email: passenger.email, name: passenger.name)
      end
  end
end
