class UserNotification < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  def trip
    @notification = Notification.find(notification_id)
    @trip = Trip.find(@notification.trip_id)
  end

  def self.display_unread(user_id)
    @all_user_notifications = UserNotification.where(user_id: user_id)
    @unread_user_notifications = @all_user_notifications.where(read: false)
    return @unread_user_notifications.count
  end
end
