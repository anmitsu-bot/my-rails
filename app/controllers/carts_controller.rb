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
    @use_point = false
  end

  def confirm

  end
  def zero
    session[:cart][params[:item_id]] = 0

  end

  def destroy

  end
end
