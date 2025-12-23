class Stock < ApplicationRecord
    belongs_to :from, class_name: "Item", foreign_key: "item_id"
end
