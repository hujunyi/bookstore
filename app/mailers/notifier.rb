class Notifier < ActionMailer::Base
  default from: "hujunyi1990@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order

    mail to: order.email, subject: "Progmatic Store Order Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order

    mail to: order.email, subject: "Progmatic Store Shipping Confirmation"
  end

  def message_sent(message)
    @message = message

    mail to: "hujunyi1990@gmail.com", subject: "left you a message"
  end
end
