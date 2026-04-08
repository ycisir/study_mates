require "test_helper"

class TopicTest < ActiveSupport::TestCase
  def setup
    @topic = Topic.new(name: "Ruby on Rails", slug: "ruby-on-rails")
  end

  test "should be valid" do
    assert @topic.valid?
  end

  test "name should be present" do
    @topic.name = nil
    assert_not @topic.valid?
  end

  test "name should be titleize" do
    @topic.name = "Ruby On Rails"
    assert @topic.valid?
  end
end
