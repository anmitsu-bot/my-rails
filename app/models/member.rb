class Member < ApplicationRecord
    has_secure_password
    has_many :orders, dependent: :destroy

    attr_accessor :current_password
    validates :password, presence: { if: :current_password },
        format: {
            with: /\A[A-Za-z]*\z/,
            message: "に数字、ひらがな、カタカナ、漢字を含めることはできません"
        },
        length: { minimum: 1, maximum: 9, 
        } ,on: :create

    validates :point,presence: true,
      numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0
    }

    validates :name, presence: true,
        format: {
            with: /\A[A-Za-z]*\z/,
            message: "に数字、ひらがな、カタカナ、漢字を含めることはできません"
        },
        length: { minimum: 1, maximum: 9, 
        },
        uniqueness: { case_sensitive: false }
end
