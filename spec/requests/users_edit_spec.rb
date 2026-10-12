require "rails_helper"

RSpec.describe "User edit", type: :request do
  fixtures :users

  let(:user) { users(:ron) }

  it "renders the edit form when signed in" do
    sign_in_as(user)
    get edit_user_path(user)
    expect(response).to have_http_status(:success)
    expect(response).to render_template("users/edit")
  end

  it "rejects invalid edit information" do
    sign_in_as(user)
    patch user_path(user), params: { user: { name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar" } }
    expect(response).to have_http_status(:unprocessable_content)
    expect(response).to render_template("users/edit")
  end

  it "edits successfully with friendly forwarding" do
    get edit_user_path(user)
    sign_in_as(user)
    expect(response).to redirect_to(edit_user_url(user))

    patch user_path(user), params: { user: { name: "Foo Bar", email: "foo@bar.com", password: "", password_confirmation: "" } }
    expect(flash).not_to be_empty
    expect(response).to redirect_to(user)
    user.reload
    expect(user.name).to eq("Foo Bar")
    expect(user.email).to eq("foo@bar.com")
  end
end