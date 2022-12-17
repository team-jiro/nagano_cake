require "test_helper"

class Public::ShipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_ships_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_ships_edit_url
    assert_response :success
  end
end
