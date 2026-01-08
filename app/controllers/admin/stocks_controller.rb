class Admin::StocksController < Admin::Base
  def index
    @stocks = Stock.all
  end
  def show
    @stock = Stock.find(params[:id])
  end

  def edit
    @stock = Stock.find(params[:id])
  end
  def update
    @stock = Stock.find(params[:id])
    @stock.assign_attributes(params[:stock])
    if @stock.save
      redirect_to [:admin, @stock], notice: "在庫情報を更新しました。"
    else
      render "edit"
    end
  end
end
