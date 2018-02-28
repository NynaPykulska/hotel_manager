require 'test_helper'

class MemoControllerTest < ActionDispatch::IntegrationTest

  setup do
    DatabaseCleaner.start
  end
 
  teardown do
    DatabaseCleaner.clean
    Rails.cache.clear
  end

  test "authenticated admin should see memo list" do
    sign_in users(:admin)
    get "/dayLog/list"
    assert_response :success
  end

  test "authenticated receptionist should see memo list" do
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
  end

  test "not authenticated user should get redirected" do
    get "/dayLog/list"
    assert_response :redirect
  end

  test "maid should get redirected" do
    sign_in users(:maid)
    get "/dayLog/list"
    assert_response :redirect
  end

  test "maitenance should get redirected" do
    sign_in users(:maitenance)
    get "/dayLog/list"
    assert_response :redirect
  end

  def assert_contains(expected_substring, string, *args)
    assert_match expected_substring, string, *args
  end

  test "post should create a new memo" do
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    post "/memos/new", :memo => { :room_id => rooms(:room_one).room_id,
                                  :description => "newly_created_memo#11223344",
                                  :deadline => Date.today.to_s,
                                  :is_done => "false",
                                  :is_recurring => "0"}
    assert_response :redirect
    follow_redirect!
    follow_redirect!

    assert_select "h4", "newly_created_memo#11223344"
  end

  test "get should delete a memo" do
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    get "/dayLog/memos/delete", id: memos(:delete_memo_request).id
    assert_response :redirect
    follow_redirect!
    follow_redirect!

    assert_select "del_memo_by_request_test", false, "This memo should have been deleted!"
  end

end
