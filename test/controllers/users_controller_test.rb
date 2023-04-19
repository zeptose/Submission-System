require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_case_worker
    @user = FactoryBot.create(:user)
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_path, params: { user: { username: 'jgordon', password: 'secret', password_confirmation: 'secret', role: 'case_worker', active: true } }
    end
    assert_equal "Successfully added jgordon as a user.", flash[:notice]
    assert_redirected_to users_path

    post users_path, params: { user: { username: nil, password: 'secret', password_confirmation: 'secret', role: 'case_worker', active: true } }
    assert_template :new
  end

  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_path(@user), params: { user: { username: @user.username, password: 'secret', password_confirmation: 'secret', role: 'case_worker', active: true } }
    assert_redirected_to users_path 

    patch user_path(@user), params: { user: { username: @user.username, password: 'secret', password_confirmation: 'secret', role: 'free rider', active: true } }
    assert_template :edit
  end

  test "should not have a show or destroy method" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "users", action: "show", id: "#{@user.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "users", action: "destroy", id: "#{@user.id}") end
  end

end