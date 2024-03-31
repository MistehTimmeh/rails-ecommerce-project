class OrderProduct < ApplicationRecord
    belongs_to :order
    belongs_to :product

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "product_quantity", "product_total_price", "updated_at"]
    end
end
