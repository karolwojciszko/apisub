require 'test_helper'

class SubscriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get subscription_get_url
    assert_response :success
  end

end
