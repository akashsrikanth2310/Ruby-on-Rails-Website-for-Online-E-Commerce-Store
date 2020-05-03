class ReturnItemMailer < ApplicationMailer
  default from: "orders@railsshop.com"

  def send_return_item_email
    @return_item = params[:return_item]
    @order = params[:order]
    @user = User.find(params[:user])
    mail(to:  @user.email, subject: "Item Return Request Accepted")
  end
end
