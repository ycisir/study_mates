require "rails_helper"

RSpec.describe "Password resets", type: :request do
  fixtures :users

  let(:user) { users(:ron) }

  # Sets a known reset token without going through the mailer
  def reset_token_for(user, sent_at: Time.zone.now)
    token = User.new_token
    user.update_columns(reset_digest: User.digest(token), reset_sent_at: sent_at)
    token
  end

  describe "GET /password_resets/new" do
    it "returns success" do
      get new_password_reset_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /password_resets" do
    it "re-renders the form for an unknown email" do
      post password_resets_path, params: { password_reset: { email: "nobody@example.com" } }
      expect(response).to have_http_status(:unprocessable_content)
      expect(flash).not_to be_empty
    end

    it "sends a reset email for a valid email" do
      expect {
        post password_resets_path, params: { password_reset: { email: user.email } }
      }.to have_enqueued_mail(UserMailer, :password_reset)

      expect(user.reload.reset_digest).to be_present
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET /password_resets/:token/edit" do
    it "redirects with the wrong email" do
      token = reset_token_for(user)
      get edit_password_reset_path(token, email: "wrong@example.com")
      expect(response).to redirect_to(root_url)
    end

    it "redirects for an inactive user" do
      token = reset_token_for(user)
      user.update_columns(activated: false)
      get edit_password_reset_path(token, email: user.email)
      expect(response).to redirect_to(root_url)
    end

    it "redirects with the wrong token" do
      reset_token_for(user)
      get edit_password_reset_path("wrong-token", email: user.email)
      expect(response).to redirect_to(root_url)
    end

    it "renders the form with a valid token and email" do
      token = reset_token_for(user)
      get edit_password_reset_path(token, email: user.email)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /password_resets/:token" do
    let(:token) { reset_token_for(user) }

    it "rejects a password and confirmation that don't match" do
      patch password_reset_path(token), params: {
        email: user.email, user: { password: "foobaz", password_confirmation: "barquux" }
      }
      expect(response).to have_http_status(:unprocessable_content)
    end

    it "rejects an empty password" do
      patch password_reset_path(token), params: {
        email: user.email, user: { password: "", password_confirmation: "" }
      }
      expect(response).to have_http_status(:unprocessable_content)
    end

    it "updates the password, signs the user in, and clears the digest" do
      patch password_reset_path(token), params: {
        email: user.email, user: { password: "newpass123", password_confirmation: "newpass123" }
      }
      expect(user.reload.reset_digest).to be_nil
      expect(session[:user_id]).to eq(user.id)
      expect(response).to have_http_status(:redirect)
    end

    it "redirects when the reset link has expired" do
      expired = reset_token_for(user, sent_at: 3.hours.ago)
      patch password_reset_path(expired), params: {
        email: user.email, user: { password: "newpass123", password_confirmation: "newpass123" }
      }
      expect(response).to redirect_to(new_password_reset_url)
    end
  end
end