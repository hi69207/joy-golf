require "test_helper"

class PrefecturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prefectures_index_url
    assert_response :success
  end

  test "should get edit" do
    get prefectures_edit_url
    assert_response :success
  end
end
