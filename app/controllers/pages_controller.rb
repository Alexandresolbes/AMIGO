class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # if user_signed_in?
    #  redirect_to trips_path
    # end
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
    @all_user_notifications = UserNotification.where(user_id: current_user.id)
    @user_notifications = []
    @all_user_notifications.each do |user_notification|
      if user_notification.notification.trip_id == @trip.id && user_notification.notification.user_id != current_user.id
        @user_notifications << user_notification
      end
    end
  end

  private

  def create_notification(wheel_choice)
    @trip = Trip.find(params[:trip_id])
    @content = "#{wheel_choice.first_name} was chosen by the wheel! What will be their treat? 💸🧽"
    @notification = Notification.new(content: @content)
    @notification.user_id = wheel_choice.id
    @notification.trip_id = @trip.id
    @notification.save!
    @notification.generate_user_notifications
    create_message(current_user, @trip, @content)
  end

  def create_message(user, trip, content)
    @trip = trip
    room = @trip.rooms.find_by_name("General")
    @message = Message.new(user_id: user.id, room_id: room.id, content: content)
    @message.save!
    generate_notifications
  end

  def generate_notifications
    @trip.users.each do |trip_user|
      if trip_user.id == current_user.id
        UserMessage.create(user_id: trip_user.id, message_id: @message.id, read: true)
      else
        UserMessage.create(user_id: trip_user.id, message_id: @message.id)
      end
    end
  end
end
