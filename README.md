# Odin Flight Booker

Created as part of the Odin Project curriculum.

rails g model airport code:string:uniq name:string city:string

rails g model flight takeoff:datetime duration:integer origin:references destination:references