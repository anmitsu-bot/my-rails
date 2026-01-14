class Admin::StocksController < Admin::Base
  def index
    @stocks = Stock.all
  end
  def update
    @stock = Stock.find(params[:id])
    stock_params = params[:stock]
    @stock.assign_attributes(stock_params)
    if @stock.save
      redirect_to [:admin, :stocks], notice: "在庫情報を更新しました。"
    else
      redirect_to [:admin, :stocks], alert: "在庫の更新に失敗しました。"
    end
  end
end
