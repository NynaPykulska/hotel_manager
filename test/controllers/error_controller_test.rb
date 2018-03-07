require 'test_helper'

class ErrorControllerTest < ActionDispatch::IntegrationTest
  
  test "should display 404 error" do
    get "/issueLog/list/non_existent"
    assert_response :missing
    assert_select "h2", "404 Nie odnaleziono strony"
  end

  test "should rescue from standard error" do
    sign_in users(:admin)
    get "/dayLog/list?date=2018-2-31"
    assert_response :error
    assert_select "h2", "500 Wystąpił nieprzewidziany błąd w aplikacji!"
  end

  test "should rescue from record not found error" do
    sign_in users(:admin)
    patch "/memos/1"
    assert_response :missing
    assert_select "h2", "404 Nie odnaleziono rekordu!"
  end

end
