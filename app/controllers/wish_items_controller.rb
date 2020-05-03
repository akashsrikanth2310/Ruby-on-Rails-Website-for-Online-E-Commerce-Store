class WishItemsController < ApplicationController
  def create
    # Find associated product and current cart
    chosen_product = Item.find(params[:item_id])
    current_wish = @current_wish

    if current_wish.items.include?(chosen_product)
      @wish_item = current_wish.wish_items.find_by(:item_id => chosen_product)
      @wish_item.quantity += 1
      #if params[:values_finder] == 1
      puts('Hi')
      # end
      #params[:values_finder] = "category"
      puts('Hello')
      #if params[:values_finder] == 3
      #params[:values_finder] = "brand"
      #end
      #if params[:values_finder] == 1
      #params[:values_finder] = "availability"
      #end
    else
      @wish_item = WishItem.new
      @wish_item.wish = current_wish
      @wish_item.item = chosen_product
    end

    @wish_item.save
    redirect_to items_path
  end


  def destroy
    @wish_item = WishItem.find(params[:id])
    @wish_item.destroy
    redirect_to wish_path(@current_wish)
  end


  private
  def line_item_params
    params.require(:wish_item).permit(:quantity,:item_id, :wish_id)
  end
end
