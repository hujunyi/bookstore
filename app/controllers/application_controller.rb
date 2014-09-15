class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authorize
  protect_from_forgery with: :exception


  private 
  def current_cart
    begin 
      cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
    end
    cart
  end
  def authorize
    if User.count > 0
      unless User.find_by_id(session[:user_id])
        redirect_to root_path, :notice => "Please log in as an admin."
      end 
    end
  end

end
