require "test_helper"

class FlowerTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flower_type_index_url
    assert_response :success
  end

  test "should get show" do
    get flower_type_show_url
    assert_response :success
  end
end
