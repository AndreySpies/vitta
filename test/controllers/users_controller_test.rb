require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_dashboard" do
    get users_admin_dashboard_url
    assert_response :success
  end

end
