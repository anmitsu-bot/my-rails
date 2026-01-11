class Detail < ApplicationRecord
    belongs_to :base, class_name: "Order", foreign_key: "order_id"
    belongs_to :bought, class_name: "Item", foreign_key: "item_id"

    validates :number,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  validate :number_does_not_exceed_stock
  def number_does_not_exceed_stock
    return if number.nil?
    return if bought.nil?
    return if bought.stock.nil?

    if number > bought.stock.number
      errors.add(:number, "が在庫数を超えています")
    end
  end
end
