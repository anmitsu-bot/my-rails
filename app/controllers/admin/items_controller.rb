class Admin::ItemsController < Admin::Base

    def index
        @items = Item.all
    end
    def search
        @items = Item.search(params[:q], params[:category])
        render "index"
    end
    def show
        @item = Item.find(params[:id])
    end
    def new
        @item = Item.new()
    end
    def edit
        @item = Item.find(params[:id])
    end
    def create
        @item = Item.new(params[:item])
        @stock = @item.stocks.new(number: 10)
        @stocks.save
        if @item.save
            redirect_to [:admin, @item], notice: "商品を登録しました。"
        else
            render "new"
        end
    end
    def update
        @item = Item.find(params[:id])
        @item.assign_attributes(params[:item])
        if @item.save
            redirect_to [:admin, @item], notice: "商品を更新しました。"
        else
            render "edit"
        end
    end
    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to :admin_items, notice: "商品を削除しました。"
    end
end
