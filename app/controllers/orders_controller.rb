class OrdersController < ApplicationController


  helper_method :sort_column, :sort_direction

  def index
    show_all = params[:showAll]
    show_restricted = params[:show_restricted]
    if show_all
      @orders = Order.all
    elsif show_restricted
      @orders = Order.where(status: "Pending Admin Approval")
    else

      @orders = Order.where(email: current_user.email)
    end
  end


  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    if params[:item_id]
      @order = Order.new
      @order.name = current_user.Name
      @order.email = current_user.email
      @order.address = current_user.address

      session[:buynow] = true
      session[:item_id] = params[:item_id]
      session[:q] = params[:q]

    end
  end


  def create
    @order = Order.new(order_params)
    if session[:buynow] && session[:item_id]
      item_id = session[:item_id]
      buyCount = session[:q].to_i

      item_found = Item.find(item_id)

      item_found.quantity = item_found.quantity - buyCount
      if item_found.purchase_count.nil?
        item_found.purchase_count = buyCount
      else
        item_found.purchase_count += buyCount
      end
      item_found.save!

      orderItem = CartItem.new
      orderItem.item_id = item_found.id
      orderItem.quantity = buyCount
      orderItem.save!
      @order.cart_items << orderItem
      session[:buynow] = nil
      session[:itemid] = nil
      session[:q] = nil
    else
      @current_cart.cart_items.each do |val|
        puts val.item.id
        @order.cart_items << val
        val.cart_id = nil
        item_found = Item.find(val.item.id)

        item_found.quantity = item_found.quantity - 1
        if item_found.purchase_count.nil?
          item_found.purchase_count = 1
        else
          item_found.purchase_count += 1
        end
        item_found.save!
      end
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
    end

    @order.status = "Pending Payment"
    @order.save!

    redirect_to payment_gateway_confirm_path order_id: @order.id
  end

  def updated
    @order = Order.find(params[:order_id])
    if params[:status] == "approve"
      @order.status = "Purchased"
      @order.save!
      if @order.save
        redirect_to orders_path(:show_restricted => 'is_restricted'), notice: 'Approved Restricted Item Request'
      else
        redirect_to orders_path(:show_restricted => 'is_restricted'), notice: 'Error Creating Return'
      end
    else
      @order.status = "Request rejected - Refunded"
      @order.save!
      if @order.save
        redirect_to orders_path(:show_restricted => 'is_restricted'), notice: 'Rejected Restricted Item Request'
      else
        redirect_to orders_path(:show_restricted => 'is_restricted'), notice: 'Error Creating Return'
      end
    end
  end

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    params[:direction] || "asc"
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :address, :pay_method)
  end



end
