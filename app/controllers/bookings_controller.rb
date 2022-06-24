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
      flash.notice = "Flight #{@booking.flight.formatted_flight_number} successfully booked! A confirmation email has been sent to each passenger."
      PassengerMailer.with(booking_id: @booking.id).thank_you.deliver_now
      redirect_to booking_path(@booking.confirmation)
    else
      flash.now[:alert] = ''
      if @booking.errors[:'passengers.name'].include?("can't be blank") ||
         @booking.errors[:'passengers.email'].include?("can't be blank")   
        flash.now[:alert] << 'The highlighted fields cannot be left blank. '
      end
      if @booking.errors[:'passengers.email'].include?('has already been taken')
        flash.now[:alert] << 'The highlighted email address has been taken by a user with a different name.'
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

  def search
    if params.has_key?(:button)
      if !params.has_key?(:search_field)
        flash.alert = 'You must select to search by Confirmation Number or Email Address.'
        redirect_to search_bookings_url
      elsif params[:search_field] == 'confirmation'
        @booking = Booking.find_by(confirmation: params[:search_param].upcase)
        if @booking
          redirect_to booking_url(@booking.confirmation)
        else
          flash.alert = 'No booking could be found with the given parameters.'
          redirect_to search_bookings_url
        end
      else
        @bookings = Booking.includes(:passengers, flight: [:origin, :destination])
                           .where('passengers.email ILIKE ?', params[:search_param])
                           .references(:passengers)
                           .order(:date, :time)
        @email = params[:search_param]
        flash.alert = 'No booking could be found with the given parameters.' if @bookings.empty?
        render :search
      end
    else
      render :search
    end
  end

  def index
    redirect_to search_bookings_url
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :name, :email])
  end
end