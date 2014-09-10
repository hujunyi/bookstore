require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received(orders(:one))
    assert_equal "Progmatic Store Order Confirmation", mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ["hujunyi1990@gmail.com"], mail.from
    assert_match /Thank you/, mail.body.encoded
  end

  test "order_shipped" do
    mail = Notifier.order_shipped(orders(:one))
    assert_equal "Progmatic Store Shipping Confirmation", mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ["hujunyi1990@gmail.com"], mail.from
    assert_match /This is just to let you know that we've shipped your recent order/, mail.body.encoded
  end

end
