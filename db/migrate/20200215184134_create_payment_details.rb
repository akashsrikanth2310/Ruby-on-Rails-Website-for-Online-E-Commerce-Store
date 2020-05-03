class CreatePaymentDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_details do |t|
      t.string :name
      t.string :card_number
      t.date :expiry
      t.string :cvv

      t.timestamps
    end
  end
end
