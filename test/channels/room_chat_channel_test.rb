require "test_helper"

class RoomChatChannelTest < ActionCable::Channel::TestCase
  def setup
    @room = rooms(:ruby)
  end

  test "subscribes and streams from correct room channel" do
    subscribe(room_id: @room.id)

    assert subscription.confirmed?
    assert_has_stream "room_chat_channel_#{@room.id}"
  end

  test "broadcasts to the correct room stream" do
    subscribe(room_id: @room.id)

    stream = "room_chat_channel_#{@room.id}"

    assert_broadcast_on(stream, { body: "Hello" }) do
      ActionCable.server.broadcast(stream, { body: "Hello" })
    end
  end
end
