module Activatable
	extend ActiveSupport::Concern

	# Activates an account.
	def activate
		update!(activated: true, activated_at: Time.current)
	end

	# Sends activation email.
	def send_activation_email
		create_activation_digest
		save!
		UserMailer.account_activation(self, activation_token).deliver_now
	end

	private

	# Creates and assigns the activation token and digest.
	def create_activation_digest
		self.activation_token = self.class.new_token
		self.activation_digest = self.class.digest(activation_token)
	end
end