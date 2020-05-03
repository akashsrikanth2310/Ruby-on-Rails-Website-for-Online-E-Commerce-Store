require 'test_helper'

class OrderProcessControllerTest < ActionDispatch::IntegrationTest
  test "should get processOrder" do
    get order_process_processOrder_url
    assert_response :success
  end

end
