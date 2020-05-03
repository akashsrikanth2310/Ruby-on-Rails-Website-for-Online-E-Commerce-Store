class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart, optional:true
  belongs_to :order, optional:true

  def total_price
    (self.quantity * self.item.cost) + tax_amount
  end

  def tax_amount
    (self.quantity * self.item.cost) * (self.item.taxslab.to_f/100)
  end

end
