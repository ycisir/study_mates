module Activatable
	extend ActiveSupport::Concern

	included do
		before_create :create_activation_digest
	end

	# Activates an account.
	def activate
		update_columns(activated: true, activated_at: Time.current)
	end

	# Sends activation email.
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	private

	# Creates and assigns the activation token and digest.
	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(activation_token)
	end
end