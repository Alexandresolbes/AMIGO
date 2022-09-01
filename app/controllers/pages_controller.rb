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
    @user = @users.sample
  end

  def invite
  end

  def send_invite
    @user = current_user
    @address = params[:address]
    @trip = Trip.find(params[:trip_id])
    @url = trip_path(@trip)

    InvitationMailer.with(user: @user, address: @address, trip: @trip).invitation_email.deliver_now
    redirect_to trip_path(@trip), notice: "Your invitation was sent."
  end

  def notifications
    @trip = Trip.find(params[:trip_id])
    @notifications = Notification.where(["user_id != ?", current_user.id])
    @notification = Notification.new()
  end
end
