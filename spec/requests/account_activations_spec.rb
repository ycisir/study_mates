require "rails_helper"

RSpec.describe "Account activations", type: :request do
  let(:token) { User.new_token }
  let!(:inactive_user) do
    User.create!(
      name: "Sam Smith", email: "sam@example.com",
      password: "password", password_confirmation: "password"
    ).tap do |u|
      u.update_columns(activation_digest: User.digest(token), activated: false, activated_at: nil)
    end
  end

  it "activates the user with a valid token and email" do
    get edit_account_activation_path(token, email: inactive_user.email)
    expect(inactive_user.reload).to be_activated
    expect(response).to have_http_status(:redirect)
  end

  it "does not activate with an invalid token" do
    get edit_account_activation_path("wrong-token", email: inactive_user.email)
    expect(inactive_user.reload).not_to be_activated
    expect(response).to redirect_to(root_url)
  end

  it "does not activate with the wrong email" do
    get edit_account_activation_path(token, email: "wrong@example.com")
    expect(inactive_user.reload).not_to be_activated
    expect(response).to redirect_to(root_url)
  end
end
