class OrdersController < ApplicationController
  def index
    @member = Member.find(current_member.id)
    @orders = @member.orders
  end

  def show
    @order = Order.find(params[:id])
    @details = @order.details
  end
  def destroy
        @order = Order.find(params[:id])
        @order.destroy
        redirect_to :account_orders, notice: "注文を削除しました。"
    end
end
