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
    create_notification(@user)
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

  private

  def create_notification(wheel_choice)
    @trip = Trip.find(params[:trip_id])
    @notification = Notification.new(content: "#{wheel_choice.first_name} was chosen by the wheel 😋")
    @notification.user_id = wheel_choice.id
    @notification.trip_id = @trip.id
    @notification.save!
    @notification.generate_user_notifications
  end
end
