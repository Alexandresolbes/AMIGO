class UserNotification < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  def trip
    @notification = Notification.find(notification_id)
    @trip = Trip.find(@notification.trip_id)
  end

  def self.display_unread(user_id)
    @all_user_notifications = UserNotification.where(user_id: user_id)
    @all_unread_user_notifications = @all_user_notifications.where(read: false)
    @unread_user_notifications = []
    @all_unread_user_notifications.each do |user_notification|
      if user_notification.notification.user_id != user_id
        @unread_user_notifications << user_notification
      end
    end
    return @unread_user_notifications.count
  end
end
