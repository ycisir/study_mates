module Activatable
	extend ActiveSupport::Concern

	# Activates an account.
	def activate
		update_columns(activated: true, activated_at: Time.current)
	end

	# Sends activation email.
	def send_activation_email
		create_activation_digest
		UserMailer.account_activation(self, activation_token).deliver_later
	end

	private

	# Creates and assigns the activation token and digest.
	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(activation_token)
	end
end