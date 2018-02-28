require 'test_helper'

class MemoFlowTest < ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  Capybara::Webkit.configure do |config|
    config.allow_url("fonts.googleapis.com")
  end

  setup do
    Capybara.current_driver = :webkit
    # Capybara::Webkit.configure do |config|
    #   config.allow_url("fonts.googleapis.com")
    # end
  end

  test "can create a new memo" do

    sign_in users(:admin)
    visit "/dayLog/list"
    click_on 'new_memo_link_button'
    
    within('#modal-add-memo') do
      assert page.has_content?('Utwórz Memo')
      select('101', from: 'memo_room_id')
      select('20', from: 'memo_deadline_4i')
      select('30', from: 'memo_deadline_5i')
      fill_in 'memo_description', with: "test_memo_description_10203040"
      fill_in 'memo_deadline', with: Date.current().to_s
      click_on 'submit_new_memo_button'
    end

    assert page.has_content?('test_memo_description_10203040')

  end

  test "can delete an existing memo" do
    # In this test we assume a memo in room 101 exists

    sign_in users(:admin)
    visit "/dayLog/list"
    assert page.has_content?('del_memo_by_user_test')

    click_on 'memo-' + memos(:delete_memo_user).id.to_s + '-more-drop'
    click_on 'Usuń'
    page.save_screenshot('memo_del.png')

    assert_not page.has_content?('del_memo_by_user_test')
  end

end