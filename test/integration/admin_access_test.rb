require "test_helper"

class AdminAccessTest < ActionDispatch::IntegrationTest
  ADMIN_PATHS = %w[/admin/users /admin/rooms /admin/topics /admin/messages].freeze

  def setup
    @admin  = users(:harry)  # admin: true
    @member = users(:ron)
  end

  ADMIN_PATHS.each do |path|
    test "guest is redirected from #{path}" do
      get path
      assert_response :redirect
    end

    test "non-admin is blocked from #{path}" do
      sign_in_as(@member)
      get path
      assert_response :redirect  # change to :forbidden if that's what your app returns
    end

    test "admin can access #{path}" do
      sign_in_as(@admin)
      get path
      assert_response :success
    end
  end
end