class Staff::StocksController < ApplicationController
  def index
    @stocks = Stock.all
  end
  def edit
    @stock = Stock.find(params[:id])
  end
  def update
    @stock = Stock.find(params[:id])
    @stock..assign_attributes(params[:stock])
    if @order.save
      redirect_to [:edit,:staff, @order], notice: "在庫情報を更新しました。"
    else
      render "edit"
    end
  end
end
