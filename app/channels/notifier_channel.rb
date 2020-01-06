class NotifierChannel < ApplicationCable::Channel
  def subscribed
     # = Room.find params[:room]
    # stream_for room

    # or
    # stream_from "room_#{params[:room]}"
  end
end
