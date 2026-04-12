class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    room = message.room

    html = ApplicationController.render(
      partial: "messages/message",
      locals: { message: message }
    )

    ActionCable.server.broadcast "room_chat_channel_#{message.room_id}", { html: html }
  end
end
