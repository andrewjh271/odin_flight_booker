class FlightsController < ApplicationController
  def index
    # fail
    if params[:flight]
      @flights = Flight.where(flight_params).where('takeoff::date = ?', params[:date])
    end
  end

  private

  def flight_params
    params.require(:flight).permit(:origin_id, :destination_id, :passengers)
  end
end