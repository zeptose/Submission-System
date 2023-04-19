require 'test_helper'

class ParentScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
        # creates the users that are for foster parents first
        # then creates the foster parents 
          create_foster_parent_users
          create_parents
        end

    should "show that scope exists for alphabeticizing customers" do
      assert_equal ["Corletti", "Egan", "Freeman"], Parent.alphabetical.all.map(&:last_name)
    end

    should "show that there are four active customers and one inactive customer" do
      assert_equal ["Egan", "Freeman"], Parent.active.all.map(&:last_name).sort
      assert_equal ["Corletti"], Parent.inactive.all.map(&:last_name).sort
    end 

    should "show that search scope exists for finding customers" do
      assert_equal ["Freeman"], Parent.search('f').all.map(&:last_name).sort
      assert_equal ["Egan"], Parent.search('e').all.map(&:last_name).sort
    end
  end
end