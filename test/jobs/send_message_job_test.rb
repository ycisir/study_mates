require "test_helper"

class SendMessageJobTest < ActiveJob::TestCase
  def setup
    @user = users(:ron)
    @room = rooms(:ruby)

    @message = Message.create!(
      body: "Hello job test",
      user: @user,
      room: @room
    )
  end

  test "job executes successfully" do
    assert_nothing_raised do
      SendMessageJob.perform_now(@message)
    end
  end
end