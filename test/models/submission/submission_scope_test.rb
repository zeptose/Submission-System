require 'test_helper'

class SubmissionScopeTest < ActiveSupport::TestCase
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
            create_submissions
        end

    should "have a working scope called chronological" do
        assert_equal ["4/3/2022", "3/3/2022"] Submission.chronological.all.map(&:date_completed)

    should "have a working scope called for_parent" do 
        assert_equal ["3/3/2022"] Submission.for_parent.(@f_jordan).all.map(&:price).sort.reverse
    end
end