class ActivitiesController < ApplicationController

  before_action :set_trip, only: [:create, :show, :new, :edit, :update, :destroy]
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def index
    @activities = policy_scope(Activity)
    @activities = Activity.where(trip_id: params[:trip_id])
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.new
    @markers = @activities.geocoded.map do |activity|
      {
      lat: activity.latitude,
      lng: activity.longitude,
      info_window: render_to_string(partial: "info_window", locals: {activity: activity})
    }
    end
  end

  def show
    authorize @activity
    @markers = [{
      lat: @activity.latitude,
      lng: @activity.longitude,
      info_window: render_to_string(partial: "info_window", locals: {activity: @activity})
    }]
  end

  def new
    @activity = Activity.new
    authorize @activity
  end

  def create
    @user = current_user
    @activity = Activity.new(activity_params)
    @activity.trip = @trip
    authorize @activity
    if @activity.save!
      participation = Participation.new(user_id: current_user.id, activity_id: @activity.id, creator: true)
      participation.save!
      create_notification(@activity, "created")
      redirect_to trip_activities_path(trip_id: @trip.id), notice: "Activity created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @activity
  end

  def update
    authorize @activity
    if @activity.update(activity_params)
      create_notification(@activity, "updated")
      redirect_to trip_activity_path, notice: "Activity updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @activity
    @activity.destroy
    redirect_to trip_activities_path(@trip), status: :see_other
  end

  private

  def activity_params
    params.require(:activity).permit(:categories, :address, :description, :min_amigos, :max_amigos, :title, :date, :photo)
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def create_notification(target, action)
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    @notification = Notification.new(content: "#{target.title} was #{action} by #{@user.first_name}")
    @notification_self = Notification.new(content: "You #{action} #{target.title}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
    @notification_self.user_id = current_user.id
    @notification_self.trip_id = @trip.id
    @notification_self.save!
    generate_user_notifications(@notification, @notification_self, @user)
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
