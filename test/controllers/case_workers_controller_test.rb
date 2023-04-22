require 'test_helper'

class CaseWorkersControllerTest < ActionDispatch::IntegrationTest
  setup do
    # no login this time; will differ for lots of tests
    @user = FactoryBot.create(:user)
    @caseworker = FactoryBot.create(:caseworker, user: @user)
  end

  # caseworker is the admin, in admin path
  test "should get index" do
    login_admin
    get caseworkers_path
    assert_response :success
    assert_not_nil assigns(:active_caseworkers)
    assert_not_nil assigns(:inactive_caseworkers)
  end

  test "should get new" do
    get new_caseworker_path
    assert_response :success
  end

  test "should create caseworker as admin" do
    login_admin
    assert_difference('Caseworker.count') do
      post caseworkers_path, params: { caseworker: { first_name: "Alex", last_name: "Gibson", 
      email: "alex888@aol.com", phone: "718-371-9252", active: true, 
      username: "agibson", password: "secret", password_confirmation: "secret", 
      role: "caseworker", greeting: "Alex!" } }
    end
    assert_equal "Alex Gibson was added to the system.", flash[:notice]
    assert_redirected_to caseworker_path(Caseworker.last)

    # post customers_path, params: { customer: { first_name: "Ted", last_name: nil, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    # assert_template :new
  end

  # test "should create new customer even if guest" do
  #   assert_difference('Customer.count') do
  #     post customers_path, params: { customer: { first_name: "Ted", last_name: "Gruberman", email: "tgruberman@example.com", phone: "412-268-2323", active: true, username: "tgruberman", password: "secret", password_confirmation: "secret", role: "customer", greeting: "Ted!" } }
  #   end
  #   assert_equal "Ted Gruberman was added to the system.", flash[:notice]
  #   assert_redirected_to customer_path(Customer.last)

    # post customers_path, params: { customer: { first_name: "Ted", last_name: nil, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    # assert_template :new
  # end

  test "should not allow guests to become caseworkers" do
    assert_difference('Caseworker.count') do
      post caseworkers_path, params: { caseworker: { role: "admin", first_name: "Alex", last_name: "Gibson", 
      email: "alex888@aol.com", phone: "718-371-9252", active: true, username: "agibson", password: "secret", 
      password_confirmation: "secret", greeting: "Alex!" } }
    end
    assert_equal "Alex Gibson was added to the system.", flash[:notice]
    alex = Caseworker.last
    assert_redirected_to caseworker_path(ted)
    alex.user.reload
    deny alex.user.role?(:caseworker), "ROLE: #{alex.user.role} :: #{session[:user_id]}"
    assert alex.user.role?(:parent), "ROLE: #{alex.user.role}"
  end

  test "should not create if customer or user invalid" do
    login_admin
    # invalid user
    post caseworkers_path, params: { caseworker: { first_name: "Alex", last_name: "Gibson", 
    email: "alex888@aol.com", phone: "718-371-9252", active: true, username: nil, password: "secret", 
    password_confirmation: "secret", role: "caseworker", greeting: "Alex!" } }
    assert_template :new
    # invalid owner
    post caseworkers_path, params: { caseworker: { first_name: nil, last_name: "Gibson", 
    email: "alex888@aol.com", phone: "718-371-9252", active: true, username: "agibson", 
    password: "secret", password_confirmation: "secret", role: "caseworker", greeting: "Alex!" } }
    assert_template :new
  end

  test "should show caseworker as admin" do
    login_caseworker
    get caseworker_path(@caseworker)
    assert_response :success
    assert_not_nil assigns(:assignments)
    assert_not_nil assigns(:submissions)
    assert_not_nil assigns(:items)
  end

    test "should not show another caseworker" do
    get caseworker_path(@caseworker)
    assert_redirected_to login_path()
    login_caseworker
    get caseworker_path(@c_alex)
    assert_response :success
    get customer_path(@caseworker)
    assert_response :redirect
  end

  test "should get edit as own caseworker" do
    login_caseworker
    get edit_caseworker_path(@c_alex)
    assert_response :success
  end

  test "should not get edit for another customer" do
    login_caseworker
    get edit_caseworker_path(@caseworker)
    assert_response :redirect
  end

  test "should update caseworker" do
    login_admin
    patch caseworker_path(@caseworker), params: { caseworker: { first_name: @caseworker.first_name, 
    last_name: @caseworker.last_name, email: "eddie@example.com", active: @customer.active } }
    assert_redirected_to caseworker_path(@caseworker)

    patch caseworker_path(@caseworker), params: { caseworker: { first_name: @caseworker.first_name, last_name: nil, 
    email: "eddie@example.con", phone: @caseworker.phone, active: @caseworker.active } }
    assert_template :edit
  end

end
