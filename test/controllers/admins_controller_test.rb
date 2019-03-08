require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admins_edit_url
    assert_response :success
  end

end
