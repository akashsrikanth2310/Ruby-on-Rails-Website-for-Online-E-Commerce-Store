class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy,:addsubscription]
  skip_before_action  :authenticate_user!, only: [:index,:show,:sort_by,:sort_column,:sort_direction]
  before_action :is_admin?, only: [:new,:create, :edit, :update, :destroy,]


  # GET /items
  # GET /items.json
  helper_method :sort_column, :sort_direction, :is_below_18?, :is_above_65?
  def index
    puts('hi')
    puts(params[:sort_param])
    #if params[:values_finder] == 1
    #  puts(params[:values_finder])
    # end
    #params[:values_finder] = "category"
      #end
    #if params[:values_finder] == 3
      #params[:values_finder] = "brand"
      #end
    #if params[:values_finder] == 1
      #params[:values_finder] = "availability"
      #end
    if params[:values_finder].present?
      Item.order(params[:sort_finder])
    end
    if params[:find_val].present? && params[:values_finder].present?
      items = Item.arel_table
      @items = Item.where(items[params[:values_finder]].matches(params[:find_val]))
    else
      @items = Item.order(sort_column + " " + sort_direction)
    end
    if(params[:filter]).present?
      @items = Item.where("quantity > ?", 0)
    end
    if(params[:clear]).present?
      @items = Item.order(sort_column + " " + sort_direction)
    end
    if(params[:popularity]).present?
      @items = Item.order(params[:popularity])
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  def sort_by
    @item = Item.where.not(quantity: 0)
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.image.attach(item_params[:image])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    puts @item.quantity
    puts @item.quantity <=0 and item_params[:quantity].to_i > 0
    if @item.quantity <=0 and item_params[:quantity].to_i > 0
      ItemSubscribeAlertMailer.with(item: @item).item_available_email.deliver_now
    end
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def addsubscription
    subscr_item = ItemSubscribe.new
    if (current_user)

      subscr_item.userid = current_user.id
      subscr_item.itemid = @item.id
      subscr_item.save

    elsif (current_user && current_user.role == 'admin' )

      subscr_item.userid = current_user.id
      subscr_item.itemid = @item.id
      subscr_item.save

    end
    respond_to do |format|
      if subscr_item.save
        format.html { redirect_to @item, notice: 'Subscribed to alert. We will notify you when item is available' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end

    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:brand, :name, :category, :is_restricted, :is_age_restricted, :quantity, :cost, :taxslab, :purchase_count, :image, :sort, :direction, :values_finder, :find_val)
  end

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    params[:direction] || "asc"
  end


  def is_below_18?
    age = ((Time.zone.now - (current_user.dob).to_time)/1.year.seconds).floor
    age < 18
  end

  def is_above_65?
    age = ((Time.zone.now - (current_user.dob).to_time)/1.year.seconds).floor
    age > 65
  end

end
