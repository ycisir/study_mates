require "rails_helper"

RSpec.describe "Sessions", type: :request do
  fixtures :users

  let(:user) { users(:harry) }

  describe "GET /signin" do
    it "renders the sign in form" do
      get signin_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("sessions/new")
    end
  end

  describe "POST /signin" do
    it "rejects a valid email with an invalid password" do
      post signin_path, params: { session: { email: user.email, password: "invalid" } }
      expect(is_signed_in?).to be false
      expect(response).to have_http_status(:unprocessable_content)
      expect(response).to render_template("sessions/new")
      expect(flash).not_to be_empty

      get root_path
      expect(flash).to be_empty
    end

    # Commented out in Minitest, enabled here
    it "signs in a regular user and redirects to their profile" do
      regular = users(:ron)
      sign_in_as(regular)
      expect(is_signed_in?).to be true
      expect(response).to redirect_to(regular)
    end

    it "signs in an admin and redirects to the admin panel" do
      sign_in_as(user) # harry
      expect(is_signed_in?).to be true
      expect(response).to redirect_to("/admin")
    end
  end

  describe "DELETE /signout" do
    # Commented out in Minitest, enabled here
    it "signs the user out" do
      sign_in_as(user)
      delete signout_path
      expect(is_signed_in?).to be false
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(signin_url)
    end
  end

  describe "remember me" do
    it "sets the remember cookie when remember_me is checked" do
      sign_in_as(user, remember_me: "1")
      expect(cookies[:remember_token]).not_to be_blank
    end

    it "clears the remember cookie when remember_me is unchecked" do
      sign_in_as(user, remember_me: "1")
      sign_in_as(user, remember_me: "0")
      expect(cookies[:remember_token]).to be_blank
    end
  end
end
