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
require 'rails_helper'

RSpec.describe Booking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
