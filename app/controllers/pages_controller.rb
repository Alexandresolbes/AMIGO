class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      redirect_to trips_path
    end
  end

  def random_wheel
    @trip = Trip.find(params[:trip_id])
    @users = @trip.users
  end
end
