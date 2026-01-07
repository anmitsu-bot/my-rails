class OrdersController < ApplicationController
  def index
    @orders = Order.where("member_id = ?", "#{current_member}")
  end

end
