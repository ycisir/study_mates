require "rails_helper"

RSpec.describe RoomChatChannel, type: :channel do
  fixtures :users, :rooms

  let(:room)   { rooms(:ruby) }
  let(:stream) { "room_chat_channel_#{room.id}" }

  it "subscribes and streams from the correct room channel" do
    subscribe(room_id: room.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from(stream)
  end

  it "broadcasts to the correct room stream" do
    subscribe(room_id: room.id)

    expect {
      ActionCable.server.broadcast(stream, { body: "Hello" })
    }.to have_broadcasted_to(stream).with(body: "Hello")
  end
end