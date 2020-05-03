require "application_system_test_case"

class ReturnItemsTest < ApplicationSystemTestCase
  setup do
    @return_item = return_items(:one)
  end

  test "visiting the index" do
    visit return_items_url
    assert_selector "h1", text: "Return Items"
  end

  test "creating a Return item" do
    visit return_items_url
    click_on "New Return Item"

    fill_in "Order", with: @return_item.order_id
    fill_in "Status", with: @return_item.status
    fill_in "User", with: @return_item.user_id
    click_on "Create Return item"

    assert_text "Return item was successfully created"
    click_on "Back"
  end

  test "updating a Return item" do
    visit return_items_url
    click_on "Edit", match: :first

    fill_in "Order", with: @return_item.order_id
    fill_in "Status", with: @return_item.status
    fill_in "User", with: @return_item.user_id
    click_on "Update Return item"

    assert_text "Return item was successfully updated"
    click_on "Back"
  end

  test "destroying a Return item" do
    visit return_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Return item was successfully destroyed"
  end
end
