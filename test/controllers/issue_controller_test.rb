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
end
