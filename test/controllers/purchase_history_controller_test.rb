require 'test_helper'

class PurchaseHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get byUser" do
    get purchase_history_byUser_url
    assert_response :success
  end

  test "should get byItem" do
    get purchase_history_byItem_url
    assert_response :success
  end

end
