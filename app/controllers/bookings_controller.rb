class BookingsController < ApplicationController

  def new
    if params[:tickets].blank?
      flash.alert = 'You must select the number of passengers in your search in order to book a flight.'
      redirect_to root_url
    else
      @booking = Booking.new
      params[:tickets].to_i.times { @booking.passengers.build }
      @flight = Flight.find(params[:flight_id])
      render :new
    end
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking.confirmation)
    else
      flash.now[:alert] = ''
      if @booking.errors[:'passengers.name'].include?("can't be blank") ||
         @booking.errors[:'passengers.email'].include?("can't be blank")   
        flash.now[:alert] << 'The highlighted fields cannot be left blank. '
      end
      if @booking.errors[:'passengers.email'].include?('has already been taken')
        flash.now[:alert] << 'Another passenger has already taken the highlighted email address.'
      end
      @flight = Flight.find(params[:booking][:flight_id])
      render :new
    end
  end

  def show
    @booking = Booking.find_by(confirmation: params[:id])
    if @booking
      render :show
    else
      flash[:alert] = 'Sorry, the booking you\'re looking for does not exist.'
      redirect_to root_url
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :name, :email])
  end
end