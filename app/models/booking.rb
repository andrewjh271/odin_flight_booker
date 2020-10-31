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
end
