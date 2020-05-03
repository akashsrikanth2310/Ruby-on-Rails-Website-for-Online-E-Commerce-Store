class PaymentDetailsController < ApplicationController
  before_action :only_see_own_pay, only: [:show,:edit,:update]
  before_action :set_payment_detail, only: [:show, :edit, :update, :destroy]

  before_action :is_admin?, only: [:index]

  # GET /payment_details
  # GET /payment_details.json
  def index
    @payment_details = PaymentDetail.all
  end

  # GET /payment_details/1
  # GET /payment_details/1.json
  def show
  end

  # GET /payment_details/new
  def new
    session[:return_to] ||= request.referer
    @payment_detail = PaymentDetail.new
  end

  # GET /payment_details/1/edit
  def edit
    session[:return_to] ||= request.referer
  end

  # POST /payment_details
  # POST /payment_details.json
  def create
    @payment_detail = PaymentDetail.new(payment_detail_params)
    @payment_detail.user_id = current_user.id
    puts "POST"
    respond_to do |format|
      if @payment_detail.save
        format.html { redirect_to session.delete(:return_to), notice: 'Payment detail was successfully created.' }
        format.json { redirect_to :back}
      else
        format.html { render :new }
        format.json { render json: @payment_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_details/1
  # PATCH/PUT /payment_details/1.json
  def update
    respond_to do |format|
      if @payment_detail.update(payment_detail_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Payment detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_detail }
      else
        format.html { render :edit }
        format.json { render json: @payment_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_details/1
  # DELETE /payment_details/1.json
  def destroy
    @payment_detail.destroy
    respond_to do |format|
      format.html { redirect_to payment_details_url, notice: 'Payment detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_detail
      @payment_detail = PaymentDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_detail_params
      params.require(:payment_detail).permit(:name, :card_number, :expiry, :cvv)
    end
end
