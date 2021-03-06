class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:create,:new]
  before_action :set_order, only: [:ship,:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.paginate(page: params[:page],per_page: 10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @cart = current_cart
    if current_cart.line_items.empty?
      redirect_to root_path, warning: "Your cart is empty."
      return
    end
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        current_cart.destroy
        session[:cart_id] = nil
        Notifier.order_received(@order)
        format.html { redirect_to root_path, success: 'Thank you for your order! You will receive a notifcation soon.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, success: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, info: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def ship
    @ship = true
    render "edit"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
