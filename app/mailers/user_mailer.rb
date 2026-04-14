class UserMailer < ApplicationMailer
	def account_activation(user, token)
		@user = user
		@token = token
		mail to: user.email, subject: "Account activation"
	end

	def password_reset(user, token)
		@user = user
		@token = token
		mail to: user.email, subject: "Password reset"
	end
end
