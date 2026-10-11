 require "simplecov"
 SimpleCov.start "rails" do
   enable_coverage :branch
 end
 SimpleCov.command_name "Minitest"

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Returns true if a test user is logged in.
    def is_signed_in?
      !session[:user_id].nil?
    end

    def sign_in_as(user)
      session[:user_id] = user.id
    end

    parallelize_setup do |worker|
      SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
    end

    parallelize_teardown do |worker|
      SimpleCov.result
    end
  end
end


class ActionDispatch::IntegrationTest
  def sign_in_as(user, password: "password", remember_me: "1")
    post signin_path, params: { session: { email: user.email, password: password, remember_me: remember_me } }
  end
end
