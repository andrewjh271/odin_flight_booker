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
  has_many :bookings, through: :passenger_bookings, inverse_of: :passengers
  has_many :flights, through: :bookings

  validates :name, :email, presence: true
  validates :email, uniqueness: true, if: -> { !email.blank? }

  def formatted_name_long
    name.slice(0, 23).upcase
  end

  def formatted_name_short
    name.slice(0, 16).upcase
  end
end
