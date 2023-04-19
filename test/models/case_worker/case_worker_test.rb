require 'test_helper'

class CaseWorkerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # Testing relationships
  should belong_to(:user)

  # Testing validations
  
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

#   should "have accessor methods for user" do
#     assert CaseWorker.new.respond_to? :username
#     assert CaseWorker.new.respond_to?(:username=)
#     assert CaseWorker.new.respond_to? :password
#     assert CaseWorker.new.respond_to?(:password=)
#     assert CaseWorker.new.respond_to? :password_confirmation
#     assert CaseWorker.new.respond_to?(:password_confirmation=)
#     assert CaseWorker.new.respond_to? :role
#     assert CaseWorker.new.respond_to?(:role=)
#     assert CaseWorker.new.respond_to? :greeting
#     assert CaseWorker.new.respond_to?(:greeting=)
#   end
end
