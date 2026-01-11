class Detail < ApplicationRecord
    belongs_to :base, class_name: "Order", foreign_key: "order_id"
    belongs_to :bought, class_name: "Item", foreign_key: "item_id"

    validates :number,
        numericality: {
            only_integer: true,
            minimum: 1,
            maximum: 10
        }

end
