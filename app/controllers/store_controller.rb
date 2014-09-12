class StoreController < ApplicationController
  skip_before_action :authorize
  def index
    session[:counter] = 0 if session[:counter].nil?
    session[:counter] += 1
    @products = Product.all
    @cart = current_cart
  end
end
