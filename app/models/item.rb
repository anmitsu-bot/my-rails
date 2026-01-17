class Item < ApplicationRecord
    has_many :details, dependent: :destroy
    has_one :stock, dependent: :destroy

    attr_accessor :stock_number

    validates :name, presence: true,
        format: {
            with: /\A[A-Za-zぁ-んァ-ヶ亜-熙ー]*\z/,
            message: "に数字,空白,スペースを含めることはできません"
        },
        length: { minimum: 1, maximum: 19, 
        },
        uniqueness: { case_sensitive: false }

    validates :price, presence: true,
        numericality: {
            only_integer: true,
            greater_than_or_equal_to: 0,
            less_than_or_equal_to: 10000
        }
    validates :category, presence: true,
        numericality: {
            only_integer: true,
            greater_than_or_equal_to: 1,
            less_than_or_equal_to: 3
        }

    validates :explanation, presence: true,
        length: {minimum: 0, maximum: 100}

    validates :stock_number, presence: true

    class << self
        def search(query, v_cate)
            rel = Item.order("id")
            #フォーム文がが存在するか否か
            if query.present?
                if v_cate == "0"
                    rel = rel.where("name LIKE ?", "%#{query}%")
                elsif v_cate == "1"
                    rel = rel.where("name = LIKE", "%#{query}%").where("category LIKE ?", "%#{v_cate}%")
                elsif v_cate == "2"
                    rel = rel.where("name LIKE ?", "%#{query}%").where("category LIKE ?", "%#{v_cate}%")
                else
                    rel = rel.where("name LIKE ?", "%#{query}%").where("category LIKE ?", "%#{v_cate}%")
                end
            else
                if v_cate == "0"
                    rel = rel.order("id")
                    rel
                else
                    rel = rel.where("category LIKE ? ", "%#{v_cate}%")
                    rel
                end
            end
        end
    end
end
