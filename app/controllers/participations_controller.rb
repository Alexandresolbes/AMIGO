class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @participation.user = current_user
    @participation.activity_id = params[:activity_id]
    if @participation.save!
      create_notification("joined")
      redirect_to activities_path, notice: "You participate in this activity."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @participation = Participation.find(params[:participation])
    authorize @participation
    @participation.destroy
    redirect_to trip_activity_path(trip_id: @participation.activity.trip.id, activity_id: @participation.activity_id), status: :see_other
  end

  private

  def create_notification(action)
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    @notification = Notification.new(content: "#{@trip.destination} trip was #{action}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
  end
end
