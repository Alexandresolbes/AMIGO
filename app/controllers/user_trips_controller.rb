class UserTripsController < ApplicationController
  def create
    @user_trip = UserTrip.new
    @user_trip.user = current_user
    @user_trip.trip = params[:trip_id]
    if @user_trip.save!
      redirect_to trips_path, notice: "You participate in this trip."
    else
      redirect_to trips_path, notice: "Error! Please try again."
    end
  end
  def destroy
    authorize @user_trip
    @user_trip.destroy
    redirect_to trips_path, status: :see_other
  end
end
