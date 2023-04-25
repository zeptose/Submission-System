require 'test_helper'

class UserTest < ActiveSupport::TestCase

  #test relationship
  # should have_one(:customer)

  #test password secure 
  should have_secure_password

  # test validations
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username).case_insensitive

  should allow_value("case_worker").for(:role)
  should allow_value("foster_parent").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value("hacker").for(:role) 
  should_not allow_value(10).for(:role)
  should_not allow_value("leader").for(:role)
  should_not allow_value(nil).for(:role)
  
  
  # context
  context "Within context" do
    setup do
      create_admin_users
    end
    
    teardown do
      destroy_admin_users
    end

    #test case senstaive username
    # should "require users to have unique, case-insensitive usernames" do
    #   assert_equal "mark", @mark.username
    #   # try to switch to Alex's username 'tank'
    #   @mark.username = "TaNK"
    #   deny @mark.valid?, "#{@mark.username}"
    # end

    #test role methods for all roles 
    should "have role methods and recognize all three roles" do
      egruberman = FactoryBot.build(:user)
      assert egruberman.role?(:foster_parent)
      deny egruberman.role?(:dog)
      assert @mark.role?(:case_worker)
      deny @mark.role?(:baker)
    end

    #test password secret 
    should "allow user to authenticate with password" do
      assert @alex.authenticate("secret")
      deny @alex.authenticate("notsecret")
    end

    #test authentication 
    should "have class method to handle authentication services" do
      assert User.authenticate("mark", "secret")
      deny User.authenticate("mark", "notsecret")
    end

    #require a password for new users
    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, username: "tank", password: nil)
      deny bad_user.valid?
    end
    
    #test and confirm passwords match
    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:user, username: "zeptose", password: "wowww", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "cooldude", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end
    
    #password is at least 4 characters
    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:user, username: "wheezy", password: "no", password_confirmation: "no")
      deny bad_user.valid?
    end



    "test alphabetical scope"
    should "have a working scope called alphabetical" do
      assert_equal ["admin", "alex","mark","rachel"], User.alphabetical.all.map(&:username)
    end

    #test employees scope
    # should "have a working scope called employees" do
    #   create_customer_users
    #   assert @u_alexe.active
    #   assert_equal ["mark","old_shipper","shipper","tank"], User.employees.all.map(&:username).sort
    #   destroy_customer_users
    # end

    #users can not be destroyed
    should "test that a user is not destroyable" do
      deny @mark.destroy
    end

    #test make active and inactive methods
    should "have make_active and make_inactive methods" do
      assert @alex.active
      @alex.make_inactive
      @alex.reload
      deny @alex.active
      @alex.make_active
      @alex.reload
      assert @alex.active
    end
  end
end
