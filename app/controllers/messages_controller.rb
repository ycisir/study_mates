class MessagesController < ApplicationController
  before_action :signed_in_user

  def create
    @message = current_user.messages.create(message_params)
    SendMessageJob.perform_later(@message)
  end

  private

  def message_params
    params.expect(message: [ :body, :room_id, { files: [] } ])
  end
end
