class ReturnItemsController < ApplicationController
  before_action :set_return_item, only: [:show, :edit, :update, :destroy]

  # GET /return_items
  # GET /return_items.json
                #helper_method :requested
  def index
    @return_items = ReturnItem.all
  end

  # GET /return_items/1
  # GET /return_items/1.json
  def show
  end

  # GET /return_items/new
  def new
    @return_item = ReturnItem.new
  end

  # GET /return_items/1/edit
  def edit
  end

  # POST /return_items
  # POST /return_items.json
  def create
    @return_item = ReturnItem.new(return_item_params)

    respond_to do |format|
      if @return_item.save
        format.html { redirect_to @return_item, notice: 'Return item was successfully created.' }
        format.json { render :show, status: :created, location: @return_item }
      else
        format.html { render :new }
        format.json { render json: @return_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /return_items/1
  # PATCH/PUT /return_items/1.json
  def update
    respond_to do |format|
      if @return_item.update(return_item_params)
        format.html { redirect_to @return_item, notice: 'Return item was successfully updated.' }
        format.json { render :show, status: :ok, location: @return_item }
      else
        format.html { render :edit }
        format.json { render json: @return_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /return_items/1
  # DELETE /return_items/1.json
  def destroy
    @return_item.destroy
    respond_to do |format|
      format.html { redirect_to return_items_url, notice: 'Return item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def requested
    print(!ReturnItem.find_by_order_id(params[:order_id]).nil?)
    if !ReturnItem.find_by_order_id(params[:order_id]).nil?
      @return_item = ReturnItem.find_by_order_id(params[:order_id])
      if @return_item.item_id.to_i.equal? params[:item_id].to_i
      redirect_to orders_path, notice: 'Return Already raised'
      else
        @return = ReturnItem.new
        @return.order_id = params[:order_id]
        @return.user_id = params[:current_user_id]
        @return.user = current_user.Name
        @return.item_id = params[:item_id]
        @return.status = 'Return Requested'
        @return.save!
        @order1 = Order.find(params[:order_id])
        @order1.status = 'Return Requested'
        @order1.save!
        if @return.save
          redirect_to orders_path, notice: 'Return Created Successfully'
        else
          redirect_to orders_path, notice: 'Error Creating Return'
        end
      end
    else
      @return = ReturnItem.new
      @return.order_id =  params[:order_id]
      @return.user_id = params[:current_user_id]
      @return.item_id = params[:item_id]
      @return.user_name = current_user.Name
      @return.status = 'Return Requested'
      @return.save!
      @order1 = Order.find(params[:order_id])
      @order1.status = 'Return Requested'
      @order1.save!
      if @return.save
        redirect_to orders_path, notice: 'Return Created Successfully'
      else
        redirect_to orders_path, notice: 'Error Creating Return'
      end
    end
  end

  def updated
    @return_item = ReturnItem.find(params[:return_item_id])
    if params[:status] == "approve"
      @return_item.status = "Returned"
      @order = Order.find(@return_item.order_id)
      @order.status = "Returned"
    else
      @order = Order.find(@return_item.order_id)
      @order.status = "Return Rejected"
      @return_item.status = "Return Rejected"
    end
    @order.save!
    @return_item.save!
    if @return_item.save
      ReturnItemMailer.with(user: @return_item.user_id,order: @order, return_item: @return_item).send_return_item_email.deliver_now
      redirect_to return_items_path, notice: 'Return Item Approved'
    else
      redirect_to return_items_path, notice: 'Error Creating Return'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_return_item
      @return_item = ReturnItem.find(params[:id])
    end

  # Only allow a list of trusted parameters through.
  def return_item_params
    # params.require().permit(:order_id, :user_id, :status)
  end

end
