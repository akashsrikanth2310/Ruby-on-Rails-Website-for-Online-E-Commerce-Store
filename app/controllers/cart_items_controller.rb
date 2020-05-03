class CartItemsController < ApplicationController
  def create
    # Find associated product and current cart
    chosen_product = Item.find(params[:item_id])
    buyQuantity = params[:q].to_i
    current_cart = @current_cart

    buyQuantity.times do
      if current_cart.items.include?(chosen_product)
        @cart_item = current_cart.cart_items.find_by(:item_id => chosen_product)
        puts("hello")
        puts(@cart_item)
        @cart_item.quantity =  @cart_item.quantity + 1
      else
        @cart_item = CartItem.new
        puts('Hi')
        @cart_item.cart = current_cart
        puts('Hello')
        @cart_item.item = chosen_product
      end
      @cart_item.save!
    end

    redirect_to items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    puts('Hello')
    @cart_item.destroy
    puts('Hello')
    redirect_to cart_path(@current_cart)
  end

  def add_quantity
    @cart_item = CartItem.find(params[:id])
    @item = Item.find(@cart_item.item_id)
    if(@cart_item.quantity < @item.quantity)
      @cart_item.quantity += 1
      @cart_item.save
    end

    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    @cart_item = CartItem.find(params[:id])
    if @cart_item.quantity > 1
      @cart_item.quantity -= 1
    end
    @cart_item.save
    redirect_to cart_path(@current_cart)
  end

    private
  def cart_item_params
    params.require(:cart_item).permit(:quantity,:item_id, :cart_id, :cart_item_id)
    end
end
