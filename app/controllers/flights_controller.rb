class FlightsController < ApplicationController
  def index
    @flight = params[:flight] ? Flight.new(search_params) : Flight.new
    if params[:flight]
      # removes fields user did not select (e.g. origin: '')
      params[:flight].delete_if { |_k, v| v.empty? }
      @flights = params[:flight].empty? ? Flight.all : Flight.where(flight_params)
    end
  end

  private

  # search_params is designed to build the Flight object that will populate the search params
  # on a redirect after a search (it includes :passengers which is not in the db table)
  # flight_params is used to query the database

  def flight_params
    params.require(:flight).permit(:origin_id, :destination_id, :date)
  end

  def search_params
    params.require(:flight).permit(:origin_id, :destination_id, :date, :tickets)
  end
end