require 'test_helper'

class IssueControllerTest < ActionDispatch::IntegrationTest
  
  test "authenticated admin should see room list" do
    sign_in users(:admin)
    get "/issueLog/list"
    assert_response :success
  end

  test "authenticated maitenance should see room list" do
    sign_in users(:maitenance)
    get "/issueLog/list"
    assert_response :success
  end

  test "not authenticated user should get redirected" do
    get "/issueLog/list"
    assert_response :redirect
  end

  test "maid should get redirected" do
    sign_in users(:maid)
    get "/issueLog/list"
    assert_response :redirect
  end

  test "receptionist should get redirected" do
    sign_in users(:receptionist)
    get "/issueLog/list"
    assert_response :redirect
  end

  test "post should mark an issue ready and reopen issue" do
    sign_in users(:maitenance)
    up_id = issues(:issue_to_update).id
    post "/issueLog/issue/mark_ready",
         params: { id: up_id.to_s }
    assert (Issue.find(up_id).is_done == true)
    post "/issueLog/issue/reopen",
         params: { id: up_id.to_s }
    assert (Issue.find(up_id).is_done == false)
  end

  test "get should delete an issue" do
    sign_in users(:maitenance)
    get "/issueLog/list"
    assert_response :success
    assert_select "h4", "delete_memo_desc"
    get "/issueLog/issue/delete",
        params: { id: issues(:issue_to_delete).id.to_s }
    assert_response :redirect
    follow_redirect!

    assert_select "delete_memo_desc", false, "This issue should have been deleted!"
  end

end
