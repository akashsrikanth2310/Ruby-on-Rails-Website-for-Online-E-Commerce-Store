class AddPaymentDetailsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :payment_details,  foreign_key: true
  end
end
