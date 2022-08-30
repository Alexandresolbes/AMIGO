class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Room.find(params[:id])
    stream_for chatroom
  end
end

def unsubscribed
  # Any cleanup needed when channel is unsubscribed
end
