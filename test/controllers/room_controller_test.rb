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

  test "post should report a new issue" do

    sign_in users(:maid)
    post "/roomStatus/report_issue", :room => { :room_id => rooms(:room_one).room_id,
                                                :issue_type => issue_types(:lampka).id,
                                                :comment => "test_issue_creation"}
    assert_response :redirect
    sign_out :user

    sign_in users(:maitenance)
    get "/issueLog/list"
    assert_response :success
    assert_select "h4", "test_issue_creation"

  end

  test "patch should update a room" do
    sign_in users(:maid)
    old_id = rooms(:room_update).room_id.to_s
    new_id = "90000"
    patch "/rooms/" + old_id, :room => { :room_id => new_id,
                                         :description => "updated_room_description",
                                         :selected_issues => ["", issue_types(:lampka).id]}

    assert_response :redirect

    get "/roomStatus/list"
    assert_response :success

    assert_select "h4", new_id
  end

end
