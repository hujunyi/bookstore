class MessagesController < ApplicationController
  skip_before_action :authorize
  def new
    @message = Message.new
  end

  def create
    @params = message_params
    @message = Message.new(message_params)
    if @message.valid?
      Notifier.message_sent(@message).deliver 
      redirect_to root_path, success: "Message Sent!"
    else
      render :new, success: "Hello"
    end
  end

  private 
  def message_params
    params.require(:message).permit(:name,:email,:content)
  end
end

