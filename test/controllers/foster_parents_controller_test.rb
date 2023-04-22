require 'test_helper'

class ParentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # no login this time; will differ for lots of tests
    @user = FactoryBot.create(:user)
    @parent = FactoryBot.create(:parent, user: @user)
  end

  test "should get index" do
    login_admin
    get parents_path
    assert_response :success
    assert_not_nil assigns(:active_parents)
    assert_not_nil assigns(:inactive_parents)
  end

  test "should get new" do
    get new_parent_path
    assert_response :success
  end

  test "should create parent as admin" do
    login_admin
    assert_difference('Parent.count') do
      post parents_path, params: { parent: { first_name: "Jordan", last_name: "Egan", 
      email: "jordan@gmail.com", phone: "412-268-8211", active: true, 
      username: "jordan", password: "secret", password_confirmation: "secret", 
      role: "parent", greeting: "Jordan!" } }
    end
    assert_equal "Jordan Egan was added to the system.", flash[:notice]
    assert_redirected_to customer_path(Parent.last)

    # post customers_path, params: { customer: { first_name: "Ted", last_name: nil, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    # assert_template :new
  end

  test "should create new parent even if guest" do
    assert_difference('Parent.count') do
      post parents_path, params: { parent: { first_name: "Audrey", last_name: "Eng", 
      email: "audrey@example.com", phone: "917-323-0000", active: true, 
      username: "areng", password: "secret", password_confirmation: "secret", 
      role: "parent", greeting: "Audrey!" } }
    end
    assert_equal "Audrey Eng was added to the system.", flash[:notice]
    assert_redirected_to parent_path(Parent.last)

    # post customers_path, params: { customer: { first_name: "Ted", last_name: nil, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    # assert_template :new
  end

  test "should not allow guests to become admins" do
    assert_difference('Parent.count') do
      post parents_path, params: { parent: { role: "admin", first_name: "Audrey", last_name: "Eng", 
      email: "audrey@example.com", phone: "917-323-0000", active: true, 
      username: "areng", password: "secret", password_confirmation: "secret", greeting: "Audrey!" } }
    end
    assert_equal "Audrey Eng was added to the system.", flash[:notice]
    audrey = Parent.last
    assert_redirected_to parent_path(audrey)
    audrey.user.reload
    deny audrey.user.role?(:case), "ROLE: #{audrey.user.role} :: #{session[:user_id]}"
    assert ted.user.role?(:parent), "ROLE: #{audrey.user.role}"
  end

  test "should not create if customer or user invalid" do
    login_admin
    # invalid user
    post parents_path, params: { parent: { first_name: "Audrey", last_name: "Eng", 
    email: "audrey@example.com", phone: "917-323-0000", active: true, username: nil, 
    password: "secret", password_confirmation: "secret", role: "parent", greeting: "Audrey!" } }
    assert_template :new
    # invalid owner
    post parents_path, params: { parent: { first_name: nil, last_name: "Eng", 
    email: "audrey@example.com", phone: "917-323-0000", active: true, username: "areng", 
    password: "secret", password_confirmation: "secret", role: "parent", greeting: "Audrey!" } }
    assert_template :new
  end

    test "should show own parent" do
    login_parent
    get parent_path(@f_becca)
    assert_response :success
    assert_not_nil assigns(:assignments)
    assert_not_nil assigns(:submissions)
    assert_not_nil assigns(:items)
  end

  test "should not show another parent" do
    get parent_path(@parent)
    assert_redirected_to login_path()
    login_parent
    get parent_path(@f_becca)
    assert_response :success
    get parent_path(@parent)
    assert_response :redirect
  end

  test "should get edit as parent" do
    login_admin
    get edit_customer_path(@customer)
    assert_response :success
  end

  test "should get edit for own customer" do
    login_parent
    get edit_parent_path(@f_becca)
    assert_response :success
  end

  test "should not get edit for another customer" do
    login_parent
    get edit_parent_path(@parent)
    assert_response :redirect
  end

  test "should update parent" do
    login_admin
    patch parent_path(@parent), params: { parent: { p1_first_name: @parent.first_name, p1_last_name: @parent.last_name, 
    email: "eddie@example.com", phone: @parent.phone, active: @parent.active } }
    assert_redirected_to customer_path(@parent)

    patch customer_path(@parent), params: { customer: { p1_first_name: @customer.first_name, p2_last_name: nil, email: "eddie@example.com", 
    phone: @parent.phone, active: @parent.active } }
    assert_template :edit
  end

end
