# Odin Flight Booker

Created as part of the Odin Project curriculum.

rails g model airport code:string:uniq name:string city:string

rails g model flight takeoff:datetime duration:integer origin:references destination:references





I initially had

```ruby
params[:tickets].to_i.times { @booking.passengers.build }
```

but because I had a many to many relationship between bookings and passengers, I need to check if the passenger already existed in the database

This ended up being a fairly easy solution presented in [this](https://medium.com/inview-technical-blog/rails-5-using-find-or-create-by-for-nested-attributes-ff633aee62a1) article: a `before_save` callback:

```ruby
def find_or_create_passenger
	self.passengers = self.passengers.map do |passenger|
  	Passenger.find_or_create_by(email: passenger.email)
  end
end
```

I had to change to a `before_validation` callback so that the uniqueness validation on `email` wouldn't trigger first. The functionality is far from realistic but I added a few elements:
`bookings` and `passengers` have a many to many relationship so that passengers can hold multiple bookings. There is a uniquness constraint on `passengers`. If a booking is made with an existing `passenger` (matching both `name` and `email`) that passenger is assigned to the booking instead of creating a new one. If a boking is made with an existing `email` but `name` that does not match, the booking form will be rendered again with the uniqueness error shown.