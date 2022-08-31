class RoomsController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @rooms = policy_scope(Room)
    @rooms = Room.where(trip_id: @trip.id)
    @message = Message.new
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @room = Room.find(params[:id])
    authorize @room
    @message = Message.new
  end
end
