class Staff::OrdersController < Staff::Base
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @details = @order.details
  end

  def edit
    @order = Order.find(params[:id])
  end
  def update
    @order = Order.find(params[:id])
    @order.assign_attributes(params[:order])
    if @order.save
      redirect_to [:staff, @order], notice: "注文情報を更新しました。"
    else
      render "edit"
    end
  end
end
