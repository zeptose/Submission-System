require 'test_helper'

class ParentMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
    # creates the users that are for foster parents first
    # then creates the foster parents 
      create_foster_parent_users
      create_parents
    end
    
    should "have make_active and make_inactive methods" do
      assert @f_jordan.active
      @f_jordan.make_inactive
      @f_jordan.reload
      deny @f_jordan.active
      @f_jordan.make_active
      @f_jordan.reload
      assert @f_jordan.active
    end
  end
end