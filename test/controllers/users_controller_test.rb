require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:harry)
    @other_user = users(:ron)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect index when not signed in" do
    get users_path
    assert_redirected_to signin_url
  end

  test "should redirect edit when not signed in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to signin_url
  end

  test "should redirect update when not signed in" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to signin_url
  end

  test "should redirect edit when signed in as wrong user" do
    sign_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when signed in as wrong user" do
    sign_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to signin_url
  end

  # test "should redirect destroy when signed in as a non-admin" do
  #   sign_in_as(@other_user)
  #   assert_no_difference 'User.count' do
  #     delete user_path(@user)
  #   end
  #   assert_response :see_other
  #   assert_redirected_to root_url
  # end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to signin_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to signin_url
  end

  # test "valid signup creates a user and sends an activation email" do
  #   ActionMailer::Base.deliveries.clear
  #   assert_difference "User.count", 1 do
  #     post users_path, params: { user: { name: "New User", email: "new@example.com",
  #                                        password: "password", password_confirmation: "password" } }
  #   end
  #   assert_equal 1, ActionMailer::Base.deliveries.size
  # end

  test "invalid signup does not create a user" do
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "", email: "bad@invalid",
                                         password: "foo", password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
  end

  test "successful update when signed in as the right user" do
    sign_in_as(@user)
    patch user_path(@user), params: { user: { name: "Harry P", email: @user.email } }
    assert_not flash.empty?
    assert_equal "Harry P", @user.reload.name
  end

  test "unsuccessful update with invalid data" do
    sign_in_as(@user)
    patch user_path(@user), params: { user: { name: "", email: "foo@invalid" } }
    assert_response :unprocessable_entity
  end

  test "admin can destroy another user" do
    sign_in_as(@user)  # harry is the admin
    assert_difference "User.count", -1 do
      delete user_path(@other_user)
    end
    assert_response :see_other
  end
end
