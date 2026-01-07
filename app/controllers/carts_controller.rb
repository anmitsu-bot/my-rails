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
    @point_amount = 0 #使うポイント数　formをインスタンスで管理すれば楽なため
  end

  def confirm
  @items = Item.where(id: session[:cart].keys)
  @member = current_member
  @sum = 0

  @order = Order.new(
    reserver: @member,
    use_point: params[:mypoint].to_i,
    reserve_time: 5.minutes.from_now
  )

  @items.each do |item|
    quantity = session[:cart][item.id.to_s].to_i
    next if quantity.zero?

      Detail.create!(
        bought: item,
        base: @order,
        number: quantity
      )

      @sum += item.price * quantity
    end

    @order.amount = @sum - @order.use_point
    @order.save

    @member.point -= @order.use_point
    @member.save

    session[:cart] = {}

    redirect_to root_path, notice: "注文が完了しました"
  end

  def zero
    session[:cart][params[:item_id]] = 0 #指定した商品の個数をゼロに
  end

end
