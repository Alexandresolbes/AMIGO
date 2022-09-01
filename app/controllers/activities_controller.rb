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
      create_notification("created", @activity)
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
      create_notification("updated", @activity)
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

  def create_notification(action, target)
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    @notification = Notification.new(content: "#{target.title} was #{action}")
    @notification.user_id = current_user.id
    @notification.trip_id = @trip.id
    @notification.save!
  end
end
