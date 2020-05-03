class AddUserRefToPaymentDetails < ActiveRecord::Migration[6.0]
  def change
    add_reference :payment_details, :user,  foreign_key: true
  end
end
