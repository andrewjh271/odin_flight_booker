# == Schema Information
#
# Table name: bookings
#
#  id         :bigint           not null, primary key
#  flight_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :booking do
    flight { nil }
  end
end
