class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @trip = Trip.find(params[:trip_id])
    @message = Message.new(message_params)
    @message.room = @room
    @message.user = current_user
    authorize @message
    if @message.save!
      ChatroomChannel.broadcast_to(
        @room,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
      generate_notifications
    else
      render trip_rooms_path(@trip), status: :unprocessable_entity
    end
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

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
