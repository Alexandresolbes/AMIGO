class UserTripsController < ApplicationController
  def create
    @user_trip = UserTrip.new
    @user_trip.user = current_user
    @user_trip.trip_id = params[:trip_id]
    authorize @user_trip
    if @user_trip.save!
      redirect_to trip_path(@user_trip.trip_id), notice: "You participate in this trip."
    else
      redirect_to trips_path, notice: "Error! Please try again."
    end
  end

  def destroy
    @user_trip = UserTrip.find(params[:user_trip])
    authorize @user_trip
    @user_trip.destroy
    redirect_to trip_path(@user_trip.trip_id), status: :see_other
  end
end
