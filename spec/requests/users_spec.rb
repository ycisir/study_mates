require 'rails_helper'

RSpec.describe "Users", type: :request do
  fixtures :users

  let(:user)       { users(:harry) }  # admin
  let(:other_user) { users(:ron) }    # regular user

  describe "GET /signup" do
    it "returns success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  context "when not signed in" do
    it "redirects index" do
      get users_path
      expect(response).to redirect_to(signin_url)
    end

    it "redirects edit and sets a flash message" do
      get edit_user_path(user)
      expect(flash).not_to be_empty
      expect(response).to redirect_to(signin_url)
    end

    it "redirects update and sets a flash message" do
      patch user_path(user), params: { user: { name: user.name, email: user.email } }
      expect(flash).not_to be_empty
      expect(response).to redirect_to(signin_url)
    end

    it "redirects destroy without deleting anyone" do
      expect { delete user_path(user) }.not_to change(User, :count)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(signin_url)
    end

    it "redirects following" do
      get following_user_path(user)
      expect(response).to redirect_to(signin_url)
    end

    it "redirects followers" do
      get followers_user_path(user)
      expect(response).to redirect_to(signin_url)
    end
  end

  context "when signed in as the wrong user" do
    before { sign_in_as(other_user) }

    it "redirects edit to root without a flash" do
      get edit_user_path(user)
      expect(flash).to be_empty
      expect(response).to redirect_to(root_url)
    end

    it "redirects update to root without a flash" do
      patch user_path(user), params: { user: { name: user.name, email: user.email } }
      expect(flash).to be_empty
      expect(response).to redirect_to(root_url)
    end

    it "does not let a non-admin destroy a user" do
      expect { delete user_path(user) }.not_to change(User, :count)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(root_url)
    end
  end
end
