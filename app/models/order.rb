class Order < ApplicationRecord
    has_many :order_products
    has_many :products, through: :order_products

    validates :order_date, :order_price, :stripe_payment_id, presence: true
    validates :stripe_payment_id, uniqueness: true

    belongs_to :user

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "order_date", "order_price", "stripe_payment_id", "updated_at"]
    end


end
