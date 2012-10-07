require 'test_helper'

class LiveControllerTest < ActionController::TestCase
  test "should get get_live_tweets" do
    get :get_live_tweets
    assert_response :success
  end

end
