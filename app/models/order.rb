class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  PAYMENT_TYPES = ['Check','Credit Card','Purchase Order']
  validates :name, :address, :email, :pay_type, presence: true 
  validates :pay_type, inclusion: {in: PAYMENT_TYPES}
  def add_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
