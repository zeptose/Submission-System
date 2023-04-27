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
            @bad_item = FactoryBot.build(:assignment, item: @Application, parent: @f_jordan, 
            case_worker: @c_alex, due_date: "05/20/2023", completion: true)
            deny @bad_item.valid?
        end

        should "only allow a single incomplete item" do
            
        end
