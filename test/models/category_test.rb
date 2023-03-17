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

    should "show that scope exists for alphabeticizing categories" do
      assert_equal %w[Certification InitialPaperwork PlacementRecord_c], Category.alphabetical.all.map(&:name)
    end

    should "show that there are three active categories and one inactive category" do
      assert_equal %w[InitialPaperwork PlacementRecord_c], Category.active.all.map(&:name).sort
      assert_equal ["Certification"], Category.inactive.all.map(&:name).sort
    end

    should "have make_active and make_inactive methods" do
      assert @PlacementRecord_c.active
      @PlacementRecord_c.make_inactive
      @PlacementRecord.reload
      
      deny @PlacementRecord_c.active
      @PlacementRecord_c.make_active
      @PlacementRecord.reload
      assert @PlacementRecord.active
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


