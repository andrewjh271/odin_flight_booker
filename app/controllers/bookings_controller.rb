class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    params[:tickets].to_i.times { @booking.passengers.build }
    @flight = Flight.find(params[:flight_id])
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      render :show
    else
      @flight = Flight.find(params[:booking][:flight_id])
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :name, :email])
  end
end