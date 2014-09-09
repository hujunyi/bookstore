class CombineItemsInCart < ActiveRecord::Migration
  def change
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id,quantity|
        cart.line_items.where(product_id: product_id).delete_all
        cart.line_items.create(product_id: product_id,quantity: quantity)
      end
    end
  end
end
