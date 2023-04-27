require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  should belong_to(:assignment)
  should have
end
