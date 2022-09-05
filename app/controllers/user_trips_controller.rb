class UserTripsController < ApplicationController
  def create
    @user_trip = UserTrip.new
    @user_trip.user = current_user
    @user_trip.trip_id = params[:trip_id]
    authorize @user_trip
    if @user_trip.save!
      Wallet.create(user_trip_id: @user_trip.id)
      redirect_to trip_path(@user_trip.trip_id), notice: "You participate in this trip."
      create_notification("joined", @user_trip)
    else
      redirect_to trips_path, notice: "Error! Please try again."
    end
  end

  def destroy
    @user_trips = UserTrip.where(user_id: current_user.id)
    @user_trip = @user_trips.where(trip_id: params[:trip_id]).first
    authorize @user_trip
    @user_trip.wallet.destroy
    @user_trip.destroy
    redirect_to trips_path, status: :see_other
  end

  private

  def create_notification(action, target)
    @user = current_user
    @trip = Trip.find(target.trip_id)
    @notification = Notification.new(content: "#{@trip.destination} trip was #{action}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
    @notification.generate_user_notifications
  end
end
