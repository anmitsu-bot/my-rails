class Order < ApplicationRecord
    belongs_to :reserver, class_name: "Member", foreign_key: "member_id"
    has_many :details, dependent: :destroy
end
