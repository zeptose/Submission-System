require 'test_helper'

class ParentCallbackTest < ActiveSupport::TestCase
    context "Within context" do
        setup do 
        # creates the users that are for foster parents first
        # then creates the foster parents 
          create_foster_parent_users
          create_parents
        end

    should "strip non-digits from the phone number" do
      assert_equal "2123063000", @f_becca.phone_number
      assert_equal "4122688211", @f_jordan.phone_number
    end

    should "correctly assess that a customer is not destroyable" do
      deny @f_jordan.destroy
    end
    
    should "deactivate the user if the customer is made inactive" do
      @f_jordan.active = false
      @f_jordan.save!
      @f_jordan.reload
      @jordan.reload
      deny @jordan.active
    end 
  end
end