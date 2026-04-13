require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Jack Sparrow", email: "jack@example.com", password: "jack123", password_confirmation: "jack123")
  end

  # test "should be valid" do
  #   assert @user.valid?
  # end

  test "name should be present" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name =  "j" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # test "authenticated? should return false for a user with nil digest" do
  #   assert_not @user.authenticated?('')
  # end

  test "associated rooms should be destroyed" do
    @user.save
    @user.rooms = [rooms(:rails)]
    assert_difference 'Room.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    harry = users(:harry)
    ron = users(:ron)
    assert_not harry.following?(ron)
    harry.follow(ron)
    assert harry.following?(ron)
    assert ron.followers.include?(harry)
    harry.unfollow(ron)
    assert_not harry.following?(ron)
    # Users can't follow themselves.
    harry.follow(harry)
    assert_not harry.following?(harry)
  end

  test "feed should have the right posts" do
    harry = users(:harry)
    ron = users(:ron)
    jack = users(:jack)
    # Posts from followed user
    jack.rooms.each do |post_following|
    assert harry.feed.include?(post_following)
    end
    # Self-posts for user with followers
    harry.rooms.each do |post_self|
    assert harry.feed.include?(post_self)
    end
    # Posts from non-followed user
    ron.rooms.each do |post_unfollowed|
    assert_not harry.feed.include?(post_unfollowed)
    end
  end
end
