module AuthHelpers
  def sign_in_as(user, password: "password")
    post signin_path, params: { session: { email: user.email, password: password } }
  end
end

RSpec.configure { |c| c.include AuthHelpers, type: :request }