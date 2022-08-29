class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  def index
    @trips = policy_scope(UserTrip)
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
    @trip.user = current_user
    authorize @trip
    if @trip.save!
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

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end
end
