require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:item)
  should belong_to(:parent)
  should have_one(:submission)

  # test simple validations with matchers
  should_not allow_value(Date.current).for(:date_completed)
  should_not allow_value(nil).for(:due_date)
  should_not allow_value(1.day.ago.to_date).for(:date_completed)
  should allow_value(1.day.from_now.to_date).for(:due_date)
  should_not allow_value("bad").for(:due_date)
  should_not allow_value(2).for(:due_date)
  should_not allow_value(3.14159).for(:due_date)
end
