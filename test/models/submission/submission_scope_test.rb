require 'test_helper'

class SubmissionScopeTest < ActiveSupport::TestCase
    context "Within context" do
        setup do 
            create_submissions
        end

    should "have a working scope called chronological" do
        assert_equal ["3/3/2022", "4/3/2022"] Submission.date_completed.all.map(&:date_completed)
    end

    should "have a working scope called for_parent" do 
        assert_equal ["3/3/2022"] Submission.for_parent.all.map(&:date_completed)
    end