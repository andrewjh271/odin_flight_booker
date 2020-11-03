# == Schema Information
#
# Table name: bookings
#
#  id           :bigint           not null, primary key
#  flight_id    :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  confirmation :string           not null
#
class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passenger_bookings, dependent: :destroy
  has_many :passengers, through: :passenger_bookings

  accepts_nested_attributes_for :passengers

  before_validation :find_or_create_passenger
  before_save :ensure_confirmation

  private

  def find_or_create_passenger
    self.passengers = self.passengers.map do |passenger|
      current = Passenger.find_or_create_by(email: passenger.email, name: passenger.name)
      current ? current : Passenger.new
    end
  end

  def ensure_confirmation
    return if confirmation

    loop do
      self.confirmation = generate_confirmation_number
      break unless self.class.where(confirmation: confirmation).exists?
    end
  end

  def generate_confirmation_number(size = 6)
    charset = %w{ A C D E F G H J K M N P Q R T V W X Y Z }
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end
end
