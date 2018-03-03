require 'test_helper'

class MemoFlowTest < ActionDispatch::IntegrationTest

  include Capybara::DSL
  include Capybara::Minitest::Assertions

  Capybara::Webkit.configure do |config|
    config.allow_url("fonts.googleapis.com")
  end

  setup do
    Capybara.current_driver = :webkit
  end

  test "report an issue" do

    sign_in users(:admin)
    visit "/roomStatus/list"
    click_on 'report_issue_button_' + rooms(:room_one).room_id.to_s
    
    within('#modal-report-issue') do
      assert page.assert_selector('.g-report-issue-card')
      find('div.report-issue-tile').click
      fill_in 'report_issue_comment', with: 'newly_reported_issue'
      click_on 'report_issue_submit_button'
    end

    visit "/issueLog/list"
    page.save_screenshot('new-issue-log.png')
    assert page.has_content?('newly_reported_issue')

  end

end