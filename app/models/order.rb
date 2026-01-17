class Order < ApplicationRecord
    belongs_to :reserver, class_name: "Member", foreign_key: "member_id"
    has_many :details, dependent: :destroy


    validates :use_point,presence: true,
      numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0
    }, on: :payment

    validate :point_cannot_exceed_reserver_point, on: :payment

    private def point_cannot_exceed_reserver_point
        return if reserver.nil?
        return if use_point.nil?

        if use_point > reserver.point
            errors.add(:use_point, "が所持ポイントを超えています")
        end
    end
end
