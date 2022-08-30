class RoomsController < ApplicationController
  def show
    @trip = Trip.find(params[:trip_id])
    @room = Room.find(params[:id])
    @message = Message.new
  end
end
