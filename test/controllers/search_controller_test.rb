require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search results" do
    ron = users(:ron)
    ruby = rooms(:ruby)

    get search_path, params: { q: "ron" }

    assert_response :success
    assert_match "Ron", @response.body
    assert_match "Ro", @response.body
  end
end
