require 'rails_helper'

RSpec.describe "Messages", type: :request do
  fixtures :users, :rooms

  let(:user) { users(:harry) }
  let(:room) { rooms(:ruby) }
  let(:message_params) { { message: { body: "Hello from spec", room_id: room.id } } }

  context "when signed in" do
    before { sign_in_as(user) }

    it "creates a message" do
      expect { post messages_url, params: message_params }.to change(Message, :count).by(1)
      expect(response).to have_http_status(:success)
    end
  end

  context "when not signed in" do
    it "does not create a message and redirects to sign in" do
      expect { post messages_url, params: message_params }.not_to change(Message, :count)
      expect(response).to redirect_to(signin_url)
    end
  end
end
