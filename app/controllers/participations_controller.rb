class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    authorize @participation
    @participation.user = current_user
    @participation.activity_id = params[:activity_id]
    @trip = Trip.find(params[:trip_id])
    if @participation.save!
      create_notification("joined", @participation.activity)
      redirect_to trip_activity_path(trip_id: @trip.id, id: params[:activity_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @participation = Participation.find(params[:participation])
    authorize @participation
    if @participation.destroy
      create_notification("left", @participation.activity)
      redirect_to trip_activity_path(trip_id: @participation.activity.trip.id, activity_id: @participation.activity_id), status: :see_other
    end
  end

  private

  def create_notification(action, target)
    @user = current_user
    @trip = Trip.find(target.trip_id)
    @notification = Notification.new(content: "#{target.title} was #{action} by #{@user.first_name}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
    @notification.generate_user_notifications
  end
end
