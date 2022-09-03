class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = policy_scope(Trip)
    @trips = UserTrip.where(user_id: current_user.id)
  end

  def show
    authorize @trip
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    authorize @trip
    if @trip.save!
      user_trip = UserTrip.new(user_id: current_user.id, trip_id: @trip.id, creator: true)
      user_trip.save!
      create_chats
      redirect_to @trip, notice: "Trip created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @trip
  end

  def update
    authorize @trip
    if @trip.update(trip_params)
      create_notification("updated")
      redirect_to @trip, notice: "Trip updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @trip
    @trip.destroy
    redirect_to trips_path, status: :see_other
  end

  def board
    @trip = Trip.find(params[:trip_id])
    authorize @trip
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end

  def create_chats
    @room_general = Room.new(trip_id: @trip.id, name: "General")
    @room_activities = Room.new(trip_id: @trip.id, name: "Activities")
    @room_housing = Room.new(trip_id: @trip.id, name: "Housing")
    @room_general.save!
    @room_activities.save!
    @room_housing.save!
  end

  def create_notification(action)
    @user = current_user
    @trip = Trip.find(params[:id])
    @notification = Notification.new(content: "#{@trip.destination} trip was #{action}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
  end
end
