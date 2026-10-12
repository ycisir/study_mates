module AuthHelpers
  def sign_in_as(user, password: "password", remember_me: "1")
    post signin_path, params: { session: { email: user.email, password: password, remember_me: remember_me } }
  end

  def is_signed_in?
    !session[:user_id].nil?
   end
end

RSpec.configure { |c| c.include AuthHelpers, type: :request }