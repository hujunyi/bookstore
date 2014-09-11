require 'test_helper'

  #one:
  #name: Dave Thomas 
  #address: MyText
  #email: dave@example.org 
  #pay_type: Check
class ShipOrderTest < ActionDispatch::IntegrationTest
  test "ship an order" do
    order = orders(:one)

    get "/orders/ship/#{order.id}"

    assert_response :success
    assert_template "edit"

    patch_via_redirect "/orders/#{order.id}",order: {ship_date: DateTime.now}
    assert_response :success


    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.org"],mail.to
    assert_equal "hujunyi1990@gmail.com",mail[:from].value
    assert_equal "Progmatic Store Shipping Confirmation",mail.subject
  end


end
