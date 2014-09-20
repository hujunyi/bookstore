class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.where(email: params[:email]).take
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, success: "Logged in!"
    else
      redirect_to login_url, warning: "Invalide email or password."
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, info: "Logged out"
  end

end
