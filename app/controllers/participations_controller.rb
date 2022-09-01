class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @participation.user = current_user
    @participation.activity_id = params[:activity_id]
    if @participation.save!
      create_notification("joined", @participation.activity)
      redirect_to trip_activity_path(trip_id: params[:trip_id], activity_id: params[:trip_id])
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

  def create_notification(action, target)
    @user = current_user
    @trip = Trip.find(target.trip_id)
    @notification = Notification.new(content: "#{target.title} was #{action}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
  end
end
