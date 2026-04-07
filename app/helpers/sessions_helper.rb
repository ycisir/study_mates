module SessionsHelper

	# Sign in given user
	def sign_in(user)
		session[:user_id] = user.id
		session[:session_token] = user.session_token
	end

	# Returns the current logged-in user (if any).
	def current_user
		if (user_id = session[:user_id])
			user = User.find_by(id: user_id)

			if user && session[:session_token] == user.session_token
				@current_user = user
			end
		elsif (user_id = cookies.encrypted[:user_id])
			user = User.find_by(id: user_id)

			if user && user.authenticated?(:remember, cookies[:remember_token])
				sign_in user
				@current_user = user
			end
		end
	end

	# Returns true if the given user is the current user.
	def current_user?(user)
		user && user == current_user
	end

	# Returns true if the user is signed in, false otherwise.
	def signed_in?
		!current_user.nil?
	end


	# Sign out current_user
	def sign_out
		forget(current_user)
		reset_session
		@current_user = nil
	end

	# Forgets a persistent session.
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# Remembers a user in a persistent session.
	def remember(user)
		user.remember
		cookies.permanent.encrypted[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# Stores the URL trying to be accessed.
	def store_location
	    session[:forwarding_url] = request.original_url if request.get?
	end
end
