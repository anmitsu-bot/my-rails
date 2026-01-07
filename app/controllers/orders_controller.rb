class OrdersController < ApplicationController
  def index
    @member = Member.find(current_member.id)
    @orders = @member.orders
  end

end
