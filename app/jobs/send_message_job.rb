class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    room = message.room

    html = ApplicationController.render(
      partial: "messages/message",
      locals: { message: message }
    )

    participants_list = room.participants.with_attached_avatar

    participants = ApplicationController.render(
      partial: "rooms/participants",
      locals: { room: room, participants: participants_list }
    )

    ActionCable.server.broadcast "room_chat_channel_#{message.room_id}", { html: html, participants: participants }
  end
end
