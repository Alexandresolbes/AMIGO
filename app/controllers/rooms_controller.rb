class RoomsController < ApplicationController
  def show
    @trip = Trip.find(params[:trip_id])
    @room = Room.find(params[:id])
    authorize @room
    @message = Message.new
  end
end
