require 'test_helper'

class WishesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
    sign_in users(:two)
    post user_session_url
  end

  test "should get show" do
    get wishes_show_url
    assert_response :success
  end

end
