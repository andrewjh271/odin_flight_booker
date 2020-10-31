# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def random_time
  Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
end

def random_date
  Faker::Date.between(from: 7.days.from_now, to: 10.days.from_now)
end

ActiveRecord::Base.transaction do
  Flight.destroy_all
  Airport.destroy_all

  a1 = Airport.create(code: 'SAN', name: 'San Diego International Airport', city: 'San Diego')
  a2 = Airport.create(code: 'DTW', name: 'Detroit Metropolitan Airport', city: 'Detroit')
  a3 = Airport.create(code: 'JFK', name: 'John F Kennedy International Airport', city: 'New York')
  # a4 = Airport.create(code: 'SFO', name: 'San Francisco International Airport', city: 'San Francisco')
  # a5 = Airport.create(code: 'ORD', name: 'O\'hare International Airport', city: 'Chicago')
  # a6 = Airport.create(code: 'SLC', name: 'Salt Lake City International Airport', city: 'Salt Lake City')
  # a7 = Airport.create(code: 'DFW', name: 'Dallas / Fort Worth International Airport', city: 'Dallas')
  # a8 = Airport.create(code: 'SEA', name: 'Seattle-Tacoma International Airport', city: 'Seattle')
  # a9 = Airport.create(code: 'BOS', name: 'Logan International Airport', city: 'Boston')
  # a10 = Airport.create(code: 'PIT', name: 'Pittsburgh International Airport', city: 'Pittsburgh')

  f1 = Flight.create(date: random_date, time: random_time, origin: a1, destination: a2, duration: 252)
  f2 = Flight.create(date: random_date, time: random_time, origin: a1, destination: a2, duration: 252)
  f3 = Flight.create(date: random_date, time: random_time, origin: a1, destination: a2, duration: 252)
  f4 = Flight.create(date: random_date, time: random_time, origin: a2, destination: a1, duration: 252)
  f5 = Flight.create(date: random_date, time: random_time, origin: a2, destination: a1, duration: 252)
  f6 = Flight.create(date: random_date, time: random_time, origin: a3, destination: a1, duration: 304)
  f7 = Flight.create(date: random_date, time: random_time, origin: a3, destination: a1, duration: 304)
  f8 = Flight.create(date: random_date, time: random_time, origin: a1, destination: a3, duration: 304)
  f9 = Flight.create(date: random_date, time: random_time, origin: a1, destination: a3, duration: 304)
end
