class Admin::StocksController < Admin::Base
  def index
    @stocks = Stock.all
  end
  def update
    @stock = Stock.find(params[:id])
    @stock.assign_attributes(params[:stock])
    if @stock.save
      redirect_to [:admin, :stocks], notice: "在庫情報を更新しました。"
    else
      render "edit"
    end
  end
end
