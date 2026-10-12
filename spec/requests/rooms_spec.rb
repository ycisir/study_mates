require "rails_helper"

RSpec.describe "Rooms", type: :request do
  fixtures :users, :rooms, :topics

  let(:harry)      { users(:harry) }  # admin
  let(:ron)        { users(:ron) }    # regular user, owns ron_room
  let(:jack)       { users(:jack) }   # regular user
  let(:harry_room) { rooms(:ruby) }
  let(:ron_room)   { rooms(:rails) }
  let(:room_params) { { room: { name: "New room", info: "A room to discuss testing Rails apps with RSpe", topic_name: "  ruby on RAILS " } } }

  context "when not signed in" do
    it "redirects create without creating a room" do
      expect { post rooms_path, params: room_params }.not_to change(Room, :count)
      expect(response).to redirect_to(signin_url)
    end

    it "redirects destroy without deleting the room" do
      expect { delete room_path(harry_room) }.not_to change(Room, :count)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(signin_url)
    end
  end

  context "when signed in as a regular user" do
    before { sign_in_as(ron) }

    it "creates a room and titleizes the topic name" do
      expect {
        post rooms_path, params: room_params
      }.to change(Room, :count).by(1)
      expect(Topic.find_by(name: "Ruby On Rails")).to be_present
    end

    it "lets the owner delete their room" do
      expect { delete room_path(ron_room) }.to change(Room, :count).by(-1)
    end

    it "does not let a user delete someone else's room" do
      expect { delete room_path(harry_room) }.not_to change(Room, :count)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(root_url)
    end
  end

  context "when signed in as an admin" do
    before { sign_in_as(harry) }

    it "lets an admin delete any room" do
      expect { delete room_path(ron_room) }.to change(Room, :count).by(-1)
    end
  end
end