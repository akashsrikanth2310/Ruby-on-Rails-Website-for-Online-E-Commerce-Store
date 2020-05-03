class Cart < ApplicationRecord
  has_many :cart_items
  has_many :items, through: :cart_items

  def sub_total
    sum = 0
    self.cart_items.each do |cart_item|
      sum += cart_item.total_price
    end
    return sum
  end

  def senior_discount
    sub_total - (sub_total*0.1)
  end

  def total_items
    if self.cart_items.present?
      return self.cart_items.count
    else
      return 0
    end
  end

end


