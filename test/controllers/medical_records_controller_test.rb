require 'test_helper'

class MedicalRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get medical_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get medical_records_edit_url
    assert_response :success
  end

end
