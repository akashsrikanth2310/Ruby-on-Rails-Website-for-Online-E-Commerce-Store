class PurchaseHistoryController < ApplicationController
  def byUser
    user = User.find(params[:user])
    @orders = Order.where(email: user.email)
  end

  def byItem
    item = params[:item]
    p item
    @orders = Order.where(cart_items: CartItem.where(item_id: item))
  end
end
