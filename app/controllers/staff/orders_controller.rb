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
  def orderc
    @order = Order.find(params[:id])
    @order.create_start = true

    @order.details.each do |detail|
      stock = detail.bought.stock
      stock.number -= detail.number

      unless stock.save
        render :index
        return
      end
    end

    if @order.save
      redirect_to [:staff, :orders], notice: "作成を開始しました。"
    else
      render :index
    end
  end
end
