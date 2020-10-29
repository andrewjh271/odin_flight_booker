FactoryBot.define do
  factory :flight do
    takeoff { "2020-10-28 23:05:49" }
    duration { 1 }
    origin { nil }
    destination { nil }
  end
end
