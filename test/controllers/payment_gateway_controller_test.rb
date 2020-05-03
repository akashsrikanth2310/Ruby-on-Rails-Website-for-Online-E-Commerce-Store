require 'test_helper'

class PaymentGatewayControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get payment_gateway_confirm_url
    assert_response :success
  end

end
