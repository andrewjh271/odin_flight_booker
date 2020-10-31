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
#
class Flight < ApplicationRecord
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

end
