require "rails_helper"

RSpec.describe "User signup", type: :request do
  it "rejects invalid signup information" do
    get signup_path
    expect {
      post users_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    }.not_to change(User, :count)
    expect(response).to have_http_status(:unprocessable_content)
    expect(response).to render_template("users/new")
  end

  # Commented out in Minitest, enabled here
  it "creates an inactive user with valid information" do
    expect {
      post users_path, params: { user: { name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password" } }
    }.to change(User, :count).by(1)
    expect(response).to have_http_status(:redirect)
    expect(User.find_by(email: "user@example.com")).not_to be_activated
  end
end