class PaymentGatewayController < ApplicationController
  def confirm

      PaymentOtpMailer.with(user: current_user).send_otp_email.deliver_now
  end

  def verifyOTP
    @order = Order.find(params[:order_id])
    if current_user.verify_otp(params[:otp])

      @order.status = "Success"
      if  @order.save
        redirect_to order_process_processOrder_path(status: 'success', reason: 'Order Processed Successfully',order: @order)
      else
        redirect_to order_process_processOrder_path(status: 'fail', reason: "Error processing order",order: @order)
      end
    else

      @order.status = "Failed"
      @order.save!
      flash[:alert] = "Invalid OTP."
      redirect_to order_process_processOrder_path(status: 'fail', reason: "Invalid OTP",order: @order)
    end

  end
end
