require 'rails_helper'

RSpec.describe "Static pages", type: :request do
  %i[home help about contact].each do |page|
    it "GET #{page} returns success" do
      get public_send("#{page}_url")
      expect(response).to have_http_status(:success)
    end
  end
end
