require 'test_helper'

class SubmissionCallbackTest < ActiveSupport::TestCase
    context "Within context" do
        setup do 
            # users need to be created before parents
            # categories need to be created before items and submissions
            create_foster_parent_users
            create_parents
            create_categories
            create_items
            create_submissions
        end

        should "mark assignment complete if submission is submitted" do
            @ryan.active = false
            @ryan.save!
            @ryan.reload
            @u_ryan.reload
            deny @u_ryan.active
          end 
    end
end