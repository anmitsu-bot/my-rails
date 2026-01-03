class ItemsController < ApplicationController
    def index
        @items = Item.order("id")
    end
    #検索
    def search
        @items = Item.search(params[:q], params[:category])
        render "index"
    end
    def show
        @item = Item.find(params[:id])
    end
end
