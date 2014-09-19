namespace :mailing do
  desc "Send mailing when an order is received"
  task order_received: :environment do
    @mailing =  Notifier.order_received
    
  end

end
