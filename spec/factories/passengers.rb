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
FactoryBot.define do
  factory :passenger do
    name { "MyString" }
    email { "MyString" }
  end
end
