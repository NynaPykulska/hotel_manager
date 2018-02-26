require 'test_helper'

class MemoControllerTest < ActionDispatch::IntegrationTest

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

end
