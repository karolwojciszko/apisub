require 'test_helper'

class GeneralControllerTest < ActionDispatch::IntegrationTest
  test "should get error" do
    get general_error_url
    assert_response :success
  end

end
