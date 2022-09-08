class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    authorize @participation
    @participation.user = current_user
    @participation.activity_id = params[:activity_id]
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
    @notification = Notification.new(content: "#{@user.first_name} #{action} #{target.title}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
    @notification_self = Notification.new(content: "You #{action} #{target.title}")
    @notification_self.user_id = current_user.id
    @notification_self.trip_id = @trip.id
    @notification_self.save!
    generate_user_notifications(@notification, @notification_self, current_user)
  end

  def generate_user_notifications(notification, notification_self, current_user)
    @users = @trip.users
    @users.each do |user|
      if user == current_user
        user_notification = UserNotification.new(user_id: user.id, notification_id: notification_self.id, read: false)
      else
        user_notification = UserNotification.new(user_id: user.id, notification_id: notification.id, read: false)
      end
      user_notification.save!
    end
  end
end
