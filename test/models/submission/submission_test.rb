require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:assignment)

  # test simple validations with matchers
  should allow_value(Date.current).for(:date_completed)
  should_not allow_value(nil).for(:date_completed)
  should allow_value(1.day.ago.to_date).for(:date_completed)
  should allow_value(1.day.from_now.to_date).for(:date_completed)
  should_not allow_value("bad").for(:date_completed)
  should_not allow_value(2).for(:date_completed)
  should_not allow_value(3.14159).for(:date_completed)
end
