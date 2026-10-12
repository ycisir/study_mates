require "rails_helper"

RSpec.describe "Admin access", type: :request do
  fixtures :users

  let(:admin)  { users(:harry) }  # admin: true
  let(:member) { users(:ron) }

  %w[/admin/users /admin/rooms /admin/topics /admin/messages].each do |path|
    describe "GET #{path}" do
      it "redirects guests" do
        get path
        expect(response).to have_http_status(:redirect)
      end

      it "blocks non-admin users" do
        sign_in_as(member)
        get path
        expect(response).to have_http_status(:redirect) # use :forbidden if that's what your app returns
      end

      it "allows admins" do
        sign_in_as(admin)
        get path
        expect(response).to have_http_status(:success)
      end
    end
  end
end