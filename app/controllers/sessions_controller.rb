class SessionsController < ApplicationController
	def new
		redirect_to(root_url, status: :see_other) if signed_in?
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user&.authenticate(params[:session][:password])
			if user.activated?
				forwarding_url = session[:forwarding_url]
				reset_session
				params[:session][:remember_me] == '1' ? remember(user) : forget(user)
				sign_in user
				redirect_to forwarding_url || user
			else
				message = "Account not activated. "
		        message += "Check your email for the activation link."
		        flash[:warning] = message
		        redirect_to root_url
			end
		else
			flash.now[:danger] = "Invalid email/password combination"
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		sign_out if signed_in?
		redirect_to signin_url, status: :see_other
	end
end
