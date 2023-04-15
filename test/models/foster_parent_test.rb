require 'test_helper'

class FosterParentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # Testing relationships
  should belong_to(:user)

  # Testing validations
  should validate_presence_of(:p1_first_name)
  should validate_presence_of(:p1_last_name)
end
