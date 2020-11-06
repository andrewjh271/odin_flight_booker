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





If all passengers from the form are invalid that means none can exist in the database with those parameters, so my params[:booking] would look something like this:

```
"booking"=>{"flight_id"=>"24", "passengers_attributes"=>{"0"=>{"name"=>"ken", "email"=>"ken@gmail.com"}, "1"=>{"name"=>"Beth", "email"=>"gmail@beth.com"}}}
```

This will not be a problem.

If one is a valid existing passenger from the databse and one is invalid, `find_or_create_passenger` will make `@booking`' contain an actual `passenger object` and would end up creating a param like 

```
"booking"=>{"flight_id"=>"24", "passengers_attributes"=>{"0"=>{"name"=>"ken", "email"=>"ken@gmail.com", "id"=>11}, "1"=>{"name"=>"Beth", "email"=>"beth@gmail.com"}}}
```

And I would get this error:

```
ActiveRecord::RecordNotFound at /bookings
Couldn't find Passenger with ID=11 for Booking with ID=
```

I think this is related to some limitations of `accepted_nested_attributes_for` as discussed [here](https://github.com/rails/rails/issues/7256). I worked for quite a while trying to figure something out, and eventually found that a solution was to add `<%= passengers_form.hidden_field :id, value: nil %>` to my new booking form will create a `param` like this:

```
"booking"=>{"flight_id"=>"24", "passengers_attributes"=>{"0"=>{"name"=>"ken", "email"=>"ken@gmail.com", "id"=>nil}, "1"=>{"name"=>"Beth", "email"=>"beth@gmail.com"}}}
```

which will not throw the `ActiveRecord::RecordNotFound` error.

I also clarified the `inverse_of` relationship in the `Booking` and `Passenger` model because I've read that sometimes that can fix issues with many to many relationships, but I don't think that made a difference here.