class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.where(email: params[:email]).take
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash[:alert] = "Email or password is invalid!"
      redirect_to login_url
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end

end
