require 'test_helper'

class RoomControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    DatabaseCleaner.start
  end
 
  teardown do
    DatabaseCleaner.clean
    Rails.cache.clear
  end

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

  test "post should create a new room" do
    sign_in users(:maid)
    post "/rooms/new", :room => { :room_id => "654123",
                                  :description => "newly_created_room#11223344",
                                  :is_other => "0",
                                  :selected_issues => ["", issue_types(:lampka).id]}

    assert_response :redirect

    get "/roomStatus/list"
    assert_response :success

    assert_select "h4", "654123"
  end

end
