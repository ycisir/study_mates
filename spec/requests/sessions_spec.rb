require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /signin" do
    it "returns success" do
      get signin_path
      expect(response).to have_http_status(:success)
    end
  end
end
