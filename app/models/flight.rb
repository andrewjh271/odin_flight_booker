# == Schema Information
#
# Table name: flights
#
#  id             :bigint           not null, primary key
#  duration       :integer          not null
#  origin_id      :bigint           not null
#  destination_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  date           :date             not null
#  time           :time             not null
#  flight_number  :integer          default(-1), not null
#
class Flight < ApplicationRecord
  def self.reset_all_flight_numbers!
    self.all.each { |flight| flight.reset_flight_number! }
  end

  attr_accessor :tickets

  belongs_to :origin, class_name: :Airport
  belongs_to :destination, class_name: :Airport
  has_many :bookings
  has_many :passengers, through: :bookings

  def formatted_date
    date.strftime("%m/%d/%Y")
  end

  def formatted_time
    time.strftime('%l:%M%P')
  end

  def boarding_time
    (time - 1800).strftime('%l:%M%P')
  end

  def formatted_duration
    "%dh %02dm" % duration.divmod(60)
  end

  def formatted_flight_number
    reset_flight_number! unless flight_number

    "OA#{flight_number}"
  end

  def reset_flight_number!
    update(flight_number: rank)
  end

  private

  def rank
    self.class.where('date = ? AND time < ?', date, time).count + 1
  end
end
