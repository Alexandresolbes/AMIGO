class UserMessage < ApplicationRecord
  belongs_to :message
  belongs_to :user

  def self.display_unread(user_id)
    @all_user_messages = UserMessage.where(user_id: user_id)
    @all_unread_user_messages = @all_user_messages.where(read: false)
    return @all_unread_user_messages.count
  end
end
