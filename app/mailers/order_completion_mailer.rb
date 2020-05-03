class OrderCompletionMailer < ApplicationMailer
  default from: "orders@railsshop.com"

  def send_order_complete_email

    @user = params[:user]
    @order = Order.find(params[:order].id)
    mail(to:  @user.email, subject: "Purchase Order Confirmation")
  end
end
