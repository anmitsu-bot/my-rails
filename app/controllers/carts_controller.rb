class CartsController < ApplicationController
  def add
    # カートが未定義なら0をデフォルト値とするHashで初期化（キーは商品ID、値は数量）
    session[:cart] ||= Hash.new(0)

    item_id  = params[:item_id]
    quantity = params[:quantity].to_i
    # カートの商品IDに対する数量を追加
    session[:cart][item_id] += quantity
    redirect_to :items, notice: "商品をカートに追加しました。"
  end

  def show
    @cart  = session[:cart] || {}
    @items = Item.find(session[:cart].keys)
  end
end
