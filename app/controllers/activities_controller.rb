class ActivitiesController < ApplicationController
  before_action :set_trip, only: [:create, :new]
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def index
    @activities = policy_scope(Activity)
    @activities = current_user.activities
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
    authorize @activity
  end

  def update
    authorize @activity
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
