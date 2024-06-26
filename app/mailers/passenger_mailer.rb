class PassengerMailer < ApplicationMailer
  def thank_you
    @booking = params[:booking]
    @url = booking_url(@booking)
    mail(to: @booking.passengers.pluck(:email),
         subject: "Thank you for booking Flight #{@booking.flight.formatted_flight_number}!")
  end
end
