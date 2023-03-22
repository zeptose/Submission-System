require 'test_helper'

# CategoryTest for Relationships #############################################
class CategoryTest < ActiveSupport::TestCase
  # Test Relationships
  should have_many(:items)

  #Test validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
end

# Category Scopes and Method Test  #############################################
class CategoryScopeMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
    end

    # testing using the NAMES of the categories, not the actual variable name of the category created
    should "show that scope exists for alphabeticizing categories" do
      assert_equal ["Certification Section", "Initial Paperwork", "Placement Record"], Category.alphabetical.all.map(&:name)
    end

    # testing using the NAMES of the categories, not the actual variable name of the category created
    should "show that there are three active categories and one inactive category" do
      assert_equal ["Certification Section" , "Placement Record"], Category.active.all.map(&:name).sort
      assert_equal ["Initial Paperwork"], Category.inactive.all.map(&:name).sort
    end

    should "have make_active and make_inactive methods" do
      assert @PlacementRecord_c.active
      @PlacementRecord_c.make_inactive
      @PlacementRecord_c.reload
      assert !@PlacementRecord_c.active, "#{@PlacementRecord_c.to_yaml}"
      
      deny @PlacementRecord_c.active
      @PlacementRecord_c.make_active
      @PlacementRecord_c.reload
      assert @PlacementRecord_c.active
    end

  end
end

# Category CallBack Deletion Test  #############################################
class CategoryCallbackTest < ActiveSupport::TestCase
  context "Within context" do
    setup do
      create_categories
    end

    should "show that categories should not be destroyable" do
      deny @InitialPaperwork.destroy
    end

  end
end


