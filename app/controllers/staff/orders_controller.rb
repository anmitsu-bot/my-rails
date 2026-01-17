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

  def ordercd
    @order = Order.find(params[:id])
    @order.created = true
    if @order.save(context: :status_update)
      redirect_to [:staff, :orders], notice: "作成を完了しました。"
    else
      render :index
    end
  end
  def orderr
    @order = Order.find(params[:id])
    @order.reserved = true
    if @order.save(context: :status_update)
      redirect_to [:staff, :orders], notice: "受け渡し完了しました。"
    else
      render :index
    end
  end
end
