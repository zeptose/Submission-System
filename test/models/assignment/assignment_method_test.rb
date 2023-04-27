require 'test_helper'

class AssignmentMethodTest < ActiveSupport::TestCase
    context "Within context" do
        setup do 
            # users need to be created before parents
            # categories need to be created before items and submissions
            create_foster_parent_users
            create_admin_users
            create_parents
            create_caseworkers
            create_categories
            create_items
        end

        should "verify that the parent item is active in the system" do
            # inactive parent item
            # application is false
            @bad_item = FactoryBot.build(:assignment, item: @Application, foster_parent: @f_jordan, 
            case_worker: @c_alex, due_date: "05/20/2023", completion: true)
            deny @bad_item.valid?
        end

        should "only allow a single incomplete item" do
            assert_equal true, @jordan_a1.single_incomplete_assignment_allowed
            assert_equal false, @connor_a1.single_incomplete_assignment_allowed
            # connor_a2 is another incomplete assignment
            @connor_a2 = FactoryBot.build(:assignment, item: @Application, foster_parent: @f_connor, 
            case_worker: @c_mark, due_date: "08/27/2023", completion: false)
            assert_equal "Only one incomplete assignment is allowed for the same parent and item", 
            @connor_a2.single_incomplete_assignment_allowed
        end

        should "allow update status of an assignment" do
            assert_equal "Due in 3 week(s)",@jordan_a1.updatestatus
            assert_equal "Due in 7 week(s)",@becca_a1.updatestatus
            assert_equal "Due in 16 week(s)",@connor_a1.updatestatus
        end
    end
end

