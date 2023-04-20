require 'test_helper'

class ParentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # no login this time; will differ for lots of tests
    @user = FactoryBot.create(:user)
    @parent = FactoryBot.create(:parent, user: @user)
  end

  test "should get index" do
    login_admin
    get customers_path
    assert_response :success
    assert_not_nil assigns(:active_customers)
    assert_not_nil assigns(:inactive_customers)
  end

  test "should get new" do
    get new_parent_path
    assert_response :success
  end

  test "should create parent as admin" do
    login_admin
    assert_difference('Customer.count') do
      post customers_path, params: { parent: { first_name: "Ted", last_name: "Gruberman", email: "tgruberman@example.com", phone: "412-268-2323", active: true, username: "tgruberman", password: "secret", password_confirmation: "secret", role: "customer", greeting: "Ted!" } }
    end
    assert_equal "Ted Gruberman was added to the system.", flash[:notice]
    assert_redirected_to customer_path(Customer.last)

    # post customers_path, params: { customer: { first_name: "Ted", last_name: nil, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    # assert_template :new
  end

  test "should create new customer even if guest" do
    assert_difference('Customer.count') do
      post customers_path, params: { customer: { first_name: "Ted", last_name: "Gruberman", email: "tgruberman@example.com", phone: "412-268-2323", active: true, username: "tgruberman", password: "secret", password_confirmation: "secret", role: "customer", greeting: "Ted!" } }
    end
    assert_equal "Ted Gruberman was added to the system.", flash[:notice]
    assert_redirected_to customer_path(Customer.last)

    # post customers_path, params: { customer: { first_name: "Ted", last_name: nil, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    # assert_template :new
  end

  test "should not allow guests to become admins" do
    assert_difference('Customer.count') do
      post customers_path, params: { customer: { role: "admin", first_name: "Ted", last_name: "Gruberman", email: "tgruberman@example.com", phone: "412-268-2323", active: true, username: "tgruberman", password: "secret", password_confirmation: "secret", greeting: "Ted!" } }
    end
    assert_equal "Ted Gruberman was added to the system.", flash[:notice]
    ted = Customer.last
    assert_redirected_to customer_path(ted)
    ted.user.reload
    deny ted.user.role?(:admin), "ROLE: #{ted.user.role} :: #{session[:user_id]}"
    assert ted.user.role?(:customer), "ROLE: #{ted.user.role}"
  end

  test "should not create if customer or user invalid" do
    login_admin
    # invalid user
    post customers_path, params: { customer: { first_name: "Ted", last_name: "Gruberman", email: "tgruberman@example.com", phone: "412-268-2323", active: true, username: nil, password: "secret", password_confirmation: "secret", role: "customer", greeting: "Ted!" } }
    assert_template :new
    # invalid owner
    post customers_path, params: { customer: { first_name: nil, last_name: "Gruberman", email: "tgruberman@example.com", phone: "412-268-2323", active: true, username: "tgruberman", password: "secret", password_confirmation: "secret", role: "customer", greeting: "Ted!" } }
    assert_template :new
  end

    test "should show own customer" do
    login_customer
    get customer_path(@jblake)
    assert_response :success
    assert_not_nil assigns(:previous_orders)
    assert_not_nil assigns(:addresses)
  end

  test "should not show another customer" do
    get customer_path(@customer)
    assert_redirected_to login_path()
    login_customer
    get customer_path(@jblake)
    assert_response :success
    get customer_path(@customer)
    assert_response :redirect
  end

  test "should get edit as admin" do
    login_admin
    get edit_customer_path(@customer)
    assert_response :success
  end

  test "should get edit for own customer" do
    login_customer
    get edit_customer_path(@jblake)
    assert_response :success
  end

  test "should not get edit for another customer" do
    login_customer
    get edit_customer_path(@customer)
    assert_response :redirect
  end

  test "should update customer" do
    login_admin
    patch customer_path(@customer), params: { customer: { first_name: @customer.first_name, last_name: @customer.last_name, email: "eddie@example.com", phone: @customer.phone, active: @customer.active } }
    assert_redirected_to customer_path(@customer)

    patch customer_path(@customer), params: { customer: { first_name: @customer.first_name, last_name: nil, email: "eddie@example.con", phone: @customer.phone, active: @customer.active } }
    assert_template :edit
  end

end
