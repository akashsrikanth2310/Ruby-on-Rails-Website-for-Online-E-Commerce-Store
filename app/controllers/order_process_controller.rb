class OrderProcessController < ApplicationController
  def processOrder
    @order = Order.find(params[:order])
    @orderCart = CartItem.where(:order_id => @order.id )
    flag = 0
    @orderCart.each do |val|
      @item = Item.find(val.item_id)
      if @item.is_restricted == true
        flag = 1
      end
    end
    if flag == 1 and @order.status != 'Failed'
      @order.status = "Pending Admin Approval"
      @order.save!
    end

     OrderCompletionMailer.with(user: current_user, order: @order, status:  @order.status, reason: params[:reason]).send_order_complete_email.deliver_now

  end
end
