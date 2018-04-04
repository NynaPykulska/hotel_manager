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
    post "/memos/new",
         params: { memo: { room_id: rooms(:room_one).room_id,
                           description: "newly_created_memo#11223344",
                           deadline: Date.today.to_s,
                           is_done: "false",
                           is_recurring: "0",
                           is_pinned: "false"}}
    assert_response :redirect
    follow_redirect!
    follow_redirect!

    assert_select "h4", "newly_created_memo#11223344"
  end

  test "post should create a new memo with daily reccurence" do
    room_one_id = rooms(:room_one).room_id
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    post "/memos/new",
          params: { memo: { room_id: room_one_id,
                            description: "newly_created_memo_daily_recurrence",
                            deadline: Date.today.to_s,
                            "deadline(4i)": "10",
                            "deadline(5i)": "00",
                            is_done: "false",
                            is_recurring: "1",
                            recurrence: "1",
                            start_date: Date.today.to_s,
                            end_date: (Date.today + 2.days).to_s }}
    assert_response :redirect
    assert (Memo.exists?(room_id: room_one_id, deadline: Date.today.all_day, is_recurring: true) and
            Memo.exists?(room_id: room_one_id, deadline: (Date.today + 1.days).all_day, is_recurring: true) and
            Memo.exists?(room_id: room_one_id, deadline: (Date.today + 2.days).all_day, is_recurring: true))
  end

  test "post should create a new memo with weekly reccurence" do
    room_one_id = rooms(:room_one).room_id
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    post "/memos/new",
          params: { memo: { room_id: room_one_id,
                            description: "newly_created_memo_weekly_recurrence",
                            deadline: Date.today.to_s,
                            "deadline(4i)": "10",
                            "deadline(5i)": "00",
                            is_done: "false",
                            is_recurring: "1",
                            recurrence: "2",
                            start_date: Date.today.to_s,
                            end_date: (Date.today + 8.days).to_s }}
    assert_response :redirect
    assert (Memo.exists?(room_id: room_one_id, deadline: Date.today.all_day, is_recurring: true) and
            Memo.exists?(room_id: room_one_id, deadline: (Date.today + 1.weeks).all_day, is_recurring: true))
  end

  test "post should create a new memo with monthly reccurence" do
    room_one_id = rooms(:room_one).room_id
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    post "/memos/new",
          params: { memo: { room_id: room_one_id,
                            description: "newly_created_memo_monthly_recurrence",
                            deadline: Date.today.to_s,
                            "deadline(4i)": "10",
                            "deadline(5i)": "00",
                            is_done: "false",
                            is_recurring: "1",
                            recurrence: "3",
                            start_date: Date.today.to_s,
                            end_date: (Date.today + 35.days).to_s }}
    assert_response :redirect
    assert (Memo.exists?(room_id: room_one_id, deadline: Date.today.all_day, is_recurring: true) and
            Memo.exists?(room_id: room_one_id, deadline: (Date.today + 1.months).all_day, is_recurring: true))
  end

  test "post should create a new memo with custom reccurence" do
    room_one_id = rooms(:room_one).room_id
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    post "/memos/new",
          params: { memo: { room_id: room_one_id,
                            description: "newly_created_memo_custom_recurrence",
                            deadline: Date.today.to_s,
                            "deadline(4i)": "10",
                            "deadline(5i)": "00",
                            is_done: "false",
                            is_recurring: "1",
                            recurrence: "4",
                            pattern: "10, 20",
                            start_date: Date.today.beginning_of_month.to_s,
                            end_date: Date.today.end_of_month.to_s }}
    assert_response :redirect
    assert (Memo.exists?(room_id: room_one_id, deadline: Date.today.change(day: 10).all_day, is_recurring: true) and
            Memo.exists?(room_id: room_one_id, deadline: Date.today.change(day: 20).all_day, is_recurring: true))
  end

  test "get should delete a memo" do
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    get "/dayLog/memos/delete",
        params: { id: memos(:delete_memo_request).id.to_s }
    assert_response :redirect
    follow_redirect!
    follow_redirect!

    assert_select "del_memo_by_request_test", false, "This memo should have been deleted!"
  end

  test "patch should update a memo" do
    sign_in users(:receptionist)
    get "/dayLog/list"
    assert_response :success
    patch "/memos/" + memos(:memo_to_update).id.to_s, 
          params: { memo: { room_id: memos(:memo_to_update).room_id,
                            description: "memo_WAS_updated",
                            deadline: memos(:memo_to_update).deadline,
                            is_done: memos(:memo_to_update).is_done,
                            is_recurring: memos(:memo_to_update).is_recurring }}
    assert_response :redirect
    follow_redirect!
    follow_redirect!

    assert_select "h4", "memo_WAS_updated"
  end

  test "post should mark a memo ready and reopen memo" do
    sign_in users(:receptionist)
    up_id = memos(:memo_to_mark_ready).id
    post "/dayLog/memos/mark_ready",
         params: { id: up_id.to_s }
    assert (Memo.find(up_id).is_done == true)
    post "/dayLog/memos/reopen",
         params: { id: up_id.to_s }
    assert (Memo.find(up_id).is_done == false)
  end

  test "post should pin and unpin memo" do
    sign_in users(:receptionist)
    up_id = memos(:memo_to_pin).id
    post "/dayLog/memos/pin",
         params: { id: up_id.to_s }
    assert (Memo.find(up_id).is_pinned == true)
    post "/dayLog/memos/pin",
         params: { id: up_id.to_s }
    assert (Memo.find(up_id).is_pinned == false)
  end

  test "pinned memo should always be visible" do
    sign_in users(:receptionist)
    for i in 1..5 do
      get "/dayLog/list?date=" + (Date.today + i.days).to_s
      assert_select "h4", "pinned_memo"
    end
  end
end
