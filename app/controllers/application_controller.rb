class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private 
  def current_cart
    if session[:cart_id].nil?
      cart = Cart.create     
      session[:cart_id] = cart.id
    else
      cart = Cart.find(session[:cart_id])
    end
    cart
  end
end
