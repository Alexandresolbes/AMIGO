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
    @user_notifications = UserNotification.where(user_id: current_user.id)
  end

  private

  def create_notification(wheel_choice)
    @trip = Trip.find(params[:trip_id])
    @content = "#{wheel_choice.first_name} was chosen by the wheel! What will be their treat? 💸🧽"
    @notification = Notification.new(content: @content)
    @notification.user_id = wheel_choice.id
    @notification.trip_id = @trip.id
    @notification.save!
    @notification_self = Notification.new(content: "You were chosen by the wheel! Oh noes! 💸")
    @notification_self.user_id = wheel_choice.id
    @notification_self.trip_id = @trip.id
    @notification_self.save!
    create_message(current_user, @trip, @content)
    generate_user_notifications(@notification, @notification_self, wheel_choice)
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
