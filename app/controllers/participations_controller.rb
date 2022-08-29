class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @participation.user = current_user
    @participation.activity = params[:activity_id]
    if @participation.save!
      redirect_to activities_path, notice: "You participate in this activity."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    authorize @participation
    @participation.destroy
    redirect_to trips_path, status: :see_other
  end
end
