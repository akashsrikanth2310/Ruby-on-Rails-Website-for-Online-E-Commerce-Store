require "application_system_test_case"

class PaymentDetailsTest < ApplicationSystemTestCase
  setup do
    @payment_detail = payment_details(:one)
  end

  test "visiting the index" do
    visit payment_details_url
    assert_selector "h1", text: "Payment Details"
  end

  test "creating a Payment detail" do
    visit payment_details_url
    click_on "New Payment Detail"

    fill_in "Card number", with: @payment_detail.card_number
    fill_in "Cvv", with: @payment_detail.cvv
    fill_in "Expiry", with: @payment_detail.expiry
    fill_in "Name", with: @payment_detail.name
    click_on "Create Payment detail"

    assert_text "Payment detail was successfully created"
    click_on "Back"
  end

  test "updating a Payment detail" do
    visit payment_details_url
    click_on "Edit", match: :first

    fill_in "Card number", with: @payment_detail.card_number
    fill_in "Cvv", with: @payment_detail.cvv
    fill_in "Expiry", with: @payment_detail.expiry
    fill_in "Name", with: @payment_detail.name
    click_on "Update Payment detail"

    assert_text "Payment detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment detail" do
    visit payment_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment detail was successfully destroyed"
  end
end
