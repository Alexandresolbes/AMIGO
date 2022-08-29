class ActivitiesController < ApplicationController

  before_action :set_trip, only: [:create, :new]
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def index
    @activities = current_user.activities
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
  end

  def new
    @activity = Activity.new
    authorize @activity
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.trip = @trip
    @activity.user = current_user
    authorize @activity
    if @activity.save!
      redirect_to @activity, notice: "Activity created !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: "Activity updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @activity
    @activity.destroy
    redirect_to activities_path, status: :see_other
  end

  private

  def activity_params
    params.require(:activity).permit(:categories, :address, :description, :min_amigos, :max_amigos, :title, :date)
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end
end

# commentaire
