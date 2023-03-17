require 'test_helper'

# ItemTest for Relationships #############################################
class ItemTest < ActiveSupport::TestCase
  # Test relationships
  should belong_to(:categories)
  
  
  # Test built-in validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  
end

# Item Scopes and Method Test  #############################################
class ItemScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
      create_items
    end

    should "order results alphabetically" do
      assert_equal ["Application", "Informational Interview","Placement Record","Training Log"], Item.alphabetical.all.map(&:name)
    end

    should "have active and inactive scopes" do
      assert_equal ["Application", "Informational Interview","Placement Record"], Item.active.all.map(&:name).sort
      assert_equal ["Training Log"], Item.inactive.all.map(&:name).sort
    end

    should "have for_category scope" do
      assert_equal ["Application", "Informational Interview"], Item.for_category(@InitialPaperwork).all.map(&:name).sort
      assert_equal ["Placement Record"], Item.for_category(@PlacementRecord_c).all.map(&:name).sort
      assert_equal ["Training Log"], Item.for_category(@Certification).all.map(&:name).sort
    end

    should "have a scope to find items by partial name" do
      assert_equal ["Informational Interview"], Item.search('interview').all.map(&:name).sort
      assert_equal ["Placement Record"], Item.search('placement').all.map(&:name).sort
    end

    should "have make_active and make_inactive methods" do
      assert @Application.active
      @Application.make_inactive
      @Application.reload
      deny @Application.active
      @Application.make_active
      @Application.reload
      assert @Application.active

    end
  end
end

# Item CallBack Deletion Test  #############################################
class ItemMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
      create_items
    end

    should "show that items should not be destroyable" do
      deny @Application.destroy
      deny @InformationalInterview.destroy
      deny @PlacementRecord_i.destroy
      deny @TrainingLogs.destroy
    end

  end
end

