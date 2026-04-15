module Recoverable
	extend ActiveSupport::Concern

	# Sets the password reset attributes.
	def create_reset_digest
		self.reset_token = self.class.new_token
		update_columns(reset_digest: self.class.digest(reset_token), reset_sent_at: Time.zone.now)
	end

	# Sends password reset email.
	def send_password_reset_email
		UserMailer.password_reset(self, reset_token).deliver_now
	end

	# Returns true if a password reset has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end
end