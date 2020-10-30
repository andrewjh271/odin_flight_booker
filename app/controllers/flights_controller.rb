class FlightsController < ApplicationController
  def index
    # fail
    @flight = params[:flight] ? Flight.new(search_params) : Flight.new
    if params[:flight]
      @flights = Flight.where(flight_params).where('takeoff::date = ?', params[:flight][:date])
    end
    # fail
  end

  private

  def flight_params
    params.require(:flight).permit(:origin_id, :destination_id)
  end

  def search_params
    params.require(:flight).permit(:origin_id, :destination_id, :date, :passengers)
  end
end