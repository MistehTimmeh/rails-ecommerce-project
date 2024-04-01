require "test_helper"

class FlowerColourControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flower_colour_index_url
    assert_response :success
  end

  test "should get show" do
    get flower_colour_show_url
    assert_response :success
  end
end
