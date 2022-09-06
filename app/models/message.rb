class Message < ApplicationRecord
  validates :content, presence: true, allow_blank: false
  belongs_to :room
  belongs_to :user
  has_many :user_messages

  def read_user_message(message_id, user_id)
    @user_messages = UserMessage.where(message_id: message_id)
    @user_message = @user_messages.where(user_id: user_id).first
    @user_message.read = true
    @user_message.save!
  end
end
