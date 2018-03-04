require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    DatabaseCleaner.start
  end
 
  teardown do
    DatabaseCleaner.clean
    Rails.cache.clear
  end

  test "authenticated admin should see user list" do
    sign_in users(:admin)
    get "/adminPanel/list"
    assert_response :success
  end

  test "authenticated maid should should get redirected" do
    sign_in users(:maid)
    get "/adminPanel/list"
    assert_response :redirect
  end

  test "not authenticated user should get redirected" do
    get "/adminPanel/list"
    assert_response :redirect
  end

  test "maitenance should get redirected" do
    sign_in users(:maitenance)
    get "/adminPanel/list"
    assert_response :redirect
  end

  test "receptionist should get redirected" do
    sign_in users(:receptionist)
    get "/adminPanel/list"
    assert_response :redirect
  end

  test "post should create a new user" do
    sign_in users(:admin)
    post "/users/create_new_user",
         params: { user: { name: "Derpy",
                           surname: "McDerpface",
                           username: "newly_created_user",
                           email: "new@user.com",
                           password: "dummy_password",
                           role: "maid" }}

    assert_response :redirect

    get "/adminPanel/list"
    assert_response :success

    assert_select "h4", "newly_created_user"
  end

  test "patch should update a user" do
    sign_in users(:admin)
    patch "/users/" + users(:user_to_update).id.to_s,
          params: { user: { name: "Derpy",
                            surname: "McDerpface",
                            username: "updated_user_name",
                            email: "new@user.com",
                            role: "maid" }}

    assert_response :redirect

    get "/adminPanel/list"
    assert_response :success

    assert_select "h4", "updated_user_name"
  end

  test "get should delete a user" do
    sign_in users(:admin)
    get "/adminPanel/user/delete",
        params: { id: users(:user_to_delete).id }

    assert_response :redirect

    get "/adminPanel/list"
    assert_response :success

    assert_select "updated_user_name", false, "This user should have been deleted!"
  end

end
