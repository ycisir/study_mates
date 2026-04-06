require "test_helper"

class UsersSignIn < ActionDispatch::IntegrationTest
  def setup
    @user = users(:harry)
  end
end

class InvalidPasswordTest < UsersSignIn
  test "signin path" do
    get signin_path
    assert_template 'sessions/new'
  end

  test "signin with valid email/invalid password" do
    post signin_path, params: { session: { email: @user.email, password: "invalid" } }
    assert_not is_signed_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

class ValidSignIn < UsersSignIn
  def setup
    super
    post signin_path, params: { session: { email: @user.email, password: "password" } }
  end
end


class ValidSignInTest < ValidSignIn
  test "valid signin" do
    assert is_signed_in?
    assert_redirected_to @user
  end

  test "redirect after signin" do
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
  end
end

class SignOut < ValidSignIn
  def setup
    super
    delete signout_path
  end
end

class SignOutTest < SignOut
  test "successful sign out" do
    assert_not is_signed_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "redirect after sign out" do
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end

class UsersSignInTest < UsersSignIn
  test "sign in with valid information followed by sign out" do
    post signin_path, params: { session: { email: @user.email, password: "password"} }
    assert is_signed_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
    delete signout_path
    assert_response :see_other
    assert_not is_signed_in?
    assert_redirected_to root_url
    delete signout_path
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end

class SignOutTest < SignOut
  test "should still work after logout in second window" do
    delete signout_path
    assert_redirected_to root_url
  end
end

class RememberingTest < UsersSignIn
  test "sign in with remembering" do
    sign_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?
  end

  test "sign in without remembering" do
    sign_in_as(@user, remember_me: '1')
    sign_in_as(@user, remember_me: '0')
    assert cookies[:remember_token].blank?
  end
end