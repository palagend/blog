require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  test 'signup test' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  '',
                                         email: 'user@invalid',
                                         password:              'foo',
                                         password_confirmation: 'bar' } }
    end
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "foo@bar.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'user_mailer/account_activation'
  end
end
