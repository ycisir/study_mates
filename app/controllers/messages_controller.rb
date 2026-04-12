class MessagesController < ApplicationController
	before_action :signed_in_user

	def create
		@message = current_user.messages.create(message_params)
		SendMessageJob.perform_later(@message)
	end

	private

	def message_params
		params.require(:message).permit(:body, :room_id, files: [])
	end
end
