class LineItemsController < ApplicationController
  skip_before_action :authorize, only: :create
  before_action :set_line_item, only: [:show, :edit, :update, :destroy,:decrement]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    @line_item = @cart.add_product(params[:product_id])

    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to root_url}
        format.js {@current_item = @line_item}
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, success: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    @cart = current_cart
    respond_to do |format|
      format.html { redirect_to line_items_path }
      format.json { head :no_content }
    end
  end


  def decrement
    @line_item.quantity -= 1
    @line_item.save
    @line_item.destroy if @line_item.quantity <= 0
    @cart = current_cart
    respond_to do |format|
      format.html { redirect_to root_path}
      format.json { head :no_content}
      format.js
    end
  end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.permit(:product_id, :cart_id)
    end
end
