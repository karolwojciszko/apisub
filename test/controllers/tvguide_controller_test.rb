require 'test_helper'

class TvguideControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get tvguide_get_url
    assert_response :success
  end

end
