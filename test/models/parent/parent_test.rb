require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # Testing relationships
  should belong_to(:user)

  # Testing validations
  should validate_presence_of(:p1_first_name)
  should validate_presence_of(:p1_last_name)

  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  should allow_value("4122683259").for(:phone_number)
  should allow_value("412-268-3259").for(:phone_number)
  should allow_value("412.268.3259").for(:phone_number)
  should allow_value("(412) 268-3259").for(:phone_number)
  
  should_not allow_value("2683259").for(:phone_number)
  should_not allow_value("4122683259x224").for(:phone_number)
  should_not allow_value("800-EAT-FOOD").for(:phone_number)
  should_not allow_value("412/268/3259").for(:phone_number)
  should_not allow_value("412-2683-259").for(:phone_number)

  should "have accessor methods for user" do
    assert Parent.new.respond_to? :username
    assert Parent.new.respond_to?(:username=)
    assert Parent.new.respond_to? :password
    assert Parent.new.respond_to?(:password=)
    assert Parent.new.respond_to? :password_confirmation
    assert Parent.new.respond_to?(:password_confirmation=)
    assert Parent.new.respond_to? :role
    assert Parent.new.respond_to?(:role=)
    assert Parent.new.respond_to? :greeting
    assert Parent.new.respond_to?(:greeting=)
  end
end
