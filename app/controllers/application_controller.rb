class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_cart
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:Name, :Phone_number, :dob, :address])
      #devise_parameter_sanitizer.for(:account_update) { |u|    u.permit(:Name, :email, :password, :current_password, :Phone_number, :dob, :address ) }
  end


  private
  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(:id => session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id] == nil
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end


  before_action :current_wish

  private
  def current_wish
    if session[:wish_id]
      wish = Wish.find_by(:id => session[:wish_id])
      if wish.present?
        @current_wish = wish
      else
        session[:wish_id] = nil
      end
    end

    if session[:wish_id] == nil
      @current_wish = Wish.create
      session[:wish_id] = @current_wish.id
    end
  end



  private

  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # halts request cycle
    end
  end

  def is_admin?
    # check if user is a admin
    # if not admin then redirect to where ever you want
    redirect_to root_path unless current_user.role == 'admin'
  end
  def only_see_own_page
    @user = User.find(params[:id])

    if current_user != @user and current_user.role != 'admin'
      redirect_to root_path, notice: "Sorry, but you are only allowed to view your own profile page."
    end
  end
  def only_see_own_pay
    @paymentDetail = PaymentDetail.find(params[:id])

    if current_user.payment_detail != @paymentDetail
      redirect_to root_path, notice: "Sorry, but you are only allowed to view your own profile page."
    end
  end
end

