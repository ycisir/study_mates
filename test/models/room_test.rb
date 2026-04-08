require "test_helper"

class RoomTest < ActiveSupport::TestCase
  def setup
    topic = topics(:ruby)
    user = users(:harry)
    @room = Room.new(name: "Ruby on Rails Conf", info: "This is Ruby on Rails Conf 2026", topic: topic, user: user)
  end

  test "should be valid" do
    assert @room.valid?
  end

  test "name should be present" do
    @room.name = nil
    assert_not @room.valid?
  end

  test "Info should be present" do
    @room.info = nil
    assert_not @room.valid?
  end

  test "Topic should be present" do
    @room.topic = nil
    assert_not @room.valid?
  end

  test "User should be present" do
    @room.user = nil
    assert_not @room.valid?
  end
end
