class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @trip = Trip.find(params[:trip_id])
    @message = Message.new(message_params)
    @message.room = @room
    @message.user = current_user
    authorize @message
    if @message.save
      ChatroomChannel.broadcast_to(
        @room,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
