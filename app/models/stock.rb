class Stock < ApplicationRecord
    belongs_to :from, class_name: "Item", foreign_key: "item_id"

    validates :number, presence: true,
        numericality: {
            only_integer: true,
            greater_than_or_equal_to: 0,
            less_than_or_equal_to: 200
        }
end
