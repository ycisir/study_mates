require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @room = rooms(:ruby)
    @user = users(:harry)
    @message = Message.new(body: "Test message", room: @room, user: @user)
  end

  test "should be valid" do
    assert @message.valid?
  end

  test "user must exist" do
    @message.user = nil
    assert_not @message.valid?
  end

  test "room must exist" do
    @message.room = nil
    assert_not @message.valid?
  end

  test "room host is not added as participant" do
    host = @room.user
    Message.create!(body: "Host message", room: @room, user: host)
    assert_not @room.participants.include?(host)
  end


  test "other user becomes participant after sending message" do
    ron = users(:ron)
    assert_not @room.participants.include?(ron)
    Message.create!(body: "Another message", room: @room, user: ron)
    @message.save
    assert @room.participants.include?(ron)
  end

  test "user is not added twice as participant" do
    ron = users(:ron)
    Message.create!(body: "First", room: @room, user: ron)
    Message.create!(body: "Second", room: @room, user: ron)
    assert_equal 1, @room.participants.where(id: ron.id).count
  end
end
