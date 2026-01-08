class Admin::OrdersController < Admin::Base
    def index
        @orders = Order.all
        @all_amount = 0
    end
    def sales
        @orders = Order.where(reserved: true)
        render "index"
        @all_amount = 0
    end
    def show
        @order = Order.find(params[:id])
        @member = @order.reserver
    end
    def edit
        @order = Order.find(params[:id])
    end
    def update
        @order = Order.find(params[:id])
        @order.assign_attributes(params[:order])
        if @order.save
            redirect_to [:admin, @order], notice: "会員情報を更新しました。"
        else
            render "edit"
        end
    end
    def destroy
        @order = Order.find(params[:id])
        @order.destroy
        redirect_to :admin_orders, notice: "注文を削除しました。"
    end
end
