class CartsController < ApplicationController
  def add
    item_id  = params[:item_id]
    quantity = params[:quantity].to_i

    # カートが未定義なら0をデフォルト値とするHashで初期化（キーは商品ID、値は数量）
    session[:cart] ||= {}
    session[:cart][item_id] ||= 0

    # カートの商品IDに対する数量を追加
    session[:cart][item_id] += quantity
    redirect_to :items, notice: "商品をカートに追加しました。"
  end

  def show
    @cart  = session[:cart] || {}
    @items = Item.where(id: session[:cart].keys)
    @sum = 0
    @use_point = false #ポイント使うか否か　あとでラジオボタンで実装
    @point_amount = 0 #使うポイント数　formをインスタンスで管理すれば楽なため
  end

  def confirm #注文確定 orderとdetailを作る
    @sum = 0
    @items = Item.where(id: session[:cart].keys)

    @member = current_member
    
    #orderのレコード作成
    @order = Order.new()
    @order.reserver = current_member
    @order.use_point = params[:mypoint]
    if @order.save
      #detailのレコード作成
       @items.each do |item|
         @detail = Detail.new()
         @detail.bought = item
         @detail.base = @order
         @detail.number = session[:cart][item.id]

         if @detail.save && session[:cart][item.id] != 0
          @sum = @sum + item.price*session[:cart][item.id]
         else
          render "show"
         end
       end
       redirect_to :root, notice: "注文が完了しました。"
    end
    @order.amount = @sum - @order.use_point
    @order.save

    @member.point = @member.point - params[:mypoint]
    @member.save

    #カートを初期化
    session[:cart] ||= {}
    session[:cart][item_id] ||= 0
  end

  def zero
    session[:cart][params[:item_id]] = 0 #指定した商品の個数をゼロに
  end
  
end
