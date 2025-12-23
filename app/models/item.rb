class Item < ApplicationRecord
    has_many :details, dependent: :destroy
    has_many :stocks, dependent: :destroy
end
