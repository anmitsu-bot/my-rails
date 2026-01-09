class Staff::StocksController < ApplicationController
  def index
    @stocks = Stock.all
  end
  def update
    @stock = Stock.find(params[:id])

    add_number = params[:stock][:number].to_i
    @stock.number += add_number
    if @stock.save
      redirect_to [:staff, :stocks], notice: "在庫情報を更新しました。"
    else
      render "index"
    end
  end
end
