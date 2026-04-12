require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:harry)
    @room = rooms(:ruby)
    sign_in_as @user
  end

  test "should create message" do
    assert_difference("Message.count", 1) do
      post messages_url, params: {
        message: {
          body: "Hello from test",
          room_id: @room.id
        }
      }
    end

    assert_response :success
  end

  test "should not create message if not signed in" do
    delete signout_url rescue nil

    assert_no_difference("Message.count") do
      post messages_url, params: {
        message: {
          body: "Hello",
          room_id: @room.id
        }
      }
    end

    assert_redirected_to signin_url
  end
end