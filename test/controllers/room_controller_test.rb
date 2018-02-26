require 'test_helper'

class RoomControllerTest < ActionDispatch::IntegrationTest
  
  test "authenticated admin should see room list" do
    sign_in users(:admin)
    get "/roomStatus/list"
    assert_response :success
  end

  test "authenticated maid should see room list" do
    sign_in users(:maid)
    get "/roomStatus/list"
    assert_response :success
  end

  test "not authenticated user should get redirected" do
    get "/roomStatus/list"
    assert_response :redirect
  end

  test "maitenance should get redirected" do
    sign_in users(:maitenance)
    get "/roomStatus/list"
    assert_response :redirect
  end

  test "receptionist should get redirected" do
    sign_in users(:receptionist)
    get "/roomStatus/list"
    assert_response :redirect
  end

end
