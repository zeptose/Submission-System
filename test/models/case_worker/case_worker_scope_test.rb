require 'test_helper'

class CaseWorkerTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
        # creates the users that are for admin users/case workers first
        # then creates the case workers 
        create_admin_users
          create_caseworkers
        end

  should "show that scope exists for alphabeticizing case workers" do
    assert_equal ["Gibson", "Heart", "Keith", "Paytas"], Parent.alphabetical.all.map(&:last_name)
  end

  
end
