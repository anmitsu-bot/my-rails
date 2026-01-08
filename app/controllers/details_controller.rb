class DetailsController < ApplicationController
  def index
    @member = current_member
    @order = @member.orders.find(params[:order_id])
    @details = @order.details

    @d_number = 0
  end
end
