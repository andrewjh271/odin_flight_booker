# == Schema Information
#
# Table name: passengers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Passenger < ApplicationRecord
  has_many :passenger_bookings, dependent: :destroy
  has_many :bookings, through: :passenger_bookings
  has_many :flights, through: :bookings

  validates :name, :email, presence: true
  validates :email, uniqueness: true, if: -> { !email.blank? }
end
