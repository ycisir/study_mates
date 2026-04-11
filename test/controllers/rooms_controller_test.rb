require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @room = rooms(:ruby)
  end

  test "should redirect create when not signed in" do
    assert_no_difference 'Room.count' do
      post rooms_path, params: { room: { content: "Lorem ipsum" } }
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference 'Room.count' do
      delete room_path(@room)
    end
    assert_response :see_other
    assert_redirected_to signin_url
  end

  test "should redirect destroy for wrong room" do
    sign_in_as(users(:harry))
    room = rooms(:rails)
    assert_no_difference 'Room.count' do
      delete room_path(room)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end
end
