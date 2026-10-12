require "rails_helper"

RSpec.describe Message, type: :model do
  fixtures :users, :rooms

  let(:room) { rooms(:ruby) }
  let(:user) { users(:harry) }
  let(:message) { Message.new(body: "Test message", room: room, user: user) }

  it "is valid with valid attributes" do
    expect(message).to be_valid
  end

  it "requires a user" do
    message.user = nil
    expect(message).not_to be_valid
  end

  it "requires a room" do
    message.room = nil
    expect(message).not_to be_valid
  end

  describe "participants" do
    let(:ron) { users(:ron) }

    it "does not add the room host as a participant" do
      host = room.user
      Message.create!(body: "Host message", room: room, user: host)
      expect(room.participants).not_to include(host)
    end

    it "adds another user as a participant after they send a message" do
      expect(room.participants).not_to include(ron)
      Message.create!(body: "Another message", room: room, user: ron)
      expect(room.participants).to include(ron)
    end

    it "does not add the same user twice" do
      Message.create!(body: "First", room: room, user: ron)
      Message.create!(body: "Second", room: room, user: ron)
      expect(room.participants.where(id: ron.id).count).to eq(1)
    end
  end
end
