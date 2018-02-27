require 'test_helper'

class MemoFlowTest < ActionDispatch::IntegrationTest

  test "can create a new memo" do
    
    # Set-up. Should be moved to some config, but I dont know where yet
    Capybara.current_driver = :webkit
    Capybara::Webkit.configure do |config|
      config.allow_url("fonts.googleapis.com")
    end

    sign_in users(:admin)
    visit "/dayLog/list"
    click_on 'new_memo_link_button'
    
    within('#modal-add-memo') do
      assert page.has_content?('Utwórz Memo')
      select('101', from: 'memo_room_id')
      select('20', from: 'memo_deadline_4i')
      select('30', from: 'memo_deadline_5i')
      fill_in 'memo_description', with: "test_memo_description_10203040"
      #page.save_screenshot('desc_creating.png')
      fill_in 'memo_deadline', with: Date.current().to_s
      #page.save_screenshot('before_creating.png')
      click_on 'submit_new_memo_button'
    end

    #page.save_screenshot('after_creating.png')
    #puts page.html
    assert page.has_content?('test_memo_description_10203040')

  end

end