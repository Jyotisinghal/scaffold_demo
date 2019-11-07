require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
 
	test "should create user" do
		assert_difference('User.count') do
			post users_url, params: { user: { name: 'sam', password: 'secret', password_confirmation: 'secret'}}
		end
		assert_redirected_to users_url
	end

	test "should update user" do
		patch user_url(@user), params: { user: { name: @user.name, password: 'secret', password_confirmation: 'secret'} }
		assert_redirected_to users_url
	end
end
