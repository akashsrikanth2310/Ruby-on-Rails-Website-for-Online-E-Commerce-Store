class WishesController < ApplicationController
  def show
    @wish = @current_wish
  end

  def destroy
    @wish = @current_wish
    @wish.destroy
    session[:wish_id] = nil
    redirect_to root_path
  end
end
