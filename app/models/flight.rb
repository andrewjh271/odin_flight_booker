# == Schema Information
#
# Table name: flights
#
#  id             :bigint           not null, primary key
#  takeoff        :datetime         not null
#  duration       :integer          not null
#  origin_id      :bigint           not null
#  destination_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Flight < ApplicationRecord
  belongs_to :origin, class_name: :Airport
  belongs_to :destination, class_name: :Airport
end
