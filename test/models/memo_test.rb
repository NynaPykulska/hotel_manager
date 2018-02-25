require 'test_helper'

class MemoTest < ActiveSupport::TestCase
  test "should not save memo without description" do
    memo = Memo.new
    assert_not memo.save
  end
end
