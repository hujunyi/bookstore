require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @dave = User.create(email: "test@example.com",password: "secret",password_confirmation: "secret")
  end
  test "should login" do
    post :create, email: @dave.email, password: "secret", password_confirmation: "secret" 
    
    assert_redirected_to root_url
    assert_equal @dave.id, session[:user_id]
  end


  test "should fail login" do
    post :create, name: @dave.email, password: "wrong"
    assert_redirected_to login_url
  end

  test "should log out" do
    delete :destroy
    assert_redirected_to root_url
  end
end
