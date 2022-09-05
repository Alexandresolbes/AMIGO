class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :user_notifications, dependent: :destroy

  def generate_user_notifications
    @trip = Trip.find(self.trip_id)
    @users = @trip.users
    @users.each do |user|
      user_notification = UserNotification.new(user_id: user.id, notification_id: self.id, read: false)
      user_notification.save!
    end
  end

  def generate_bill_notifications
    @trip = Trip.find(self.trip_id)
    @users = @trip.users
    @users.each do |user|
      user_notification = UserNotification.new(user_id: user.id, notification_id: self.id, read: false)
      user_notification.save!
    end
  end
end
