class Staff::StocksController < Staff::Base
  def index
    @stocks = Stock.all
  end
  def update
    @stock = Stock.find(params[:id])

    add_number = params[:stock][:number].to_i
    if add_number != 0
      @stock.number += add_number
    end
    if @stock.save && add_number != 0
      redirect_to [:staff, :stocks], notice: "在庫情報を更新しました。"
    elsif add_number == 0
      redirect_to [:staff, :stocks], alert: "在庫の更新に失敗しました。"
    else
      redirect_to [:staff, :stocks], alert: "在庫の更新に失敗しました。"
    end
  end
end
