class Product < ApplicationRecord
    belongs_to :flower_colour
    belongs_to :flower_type

    validates :price_cents, :description, presence: true

    has_one_attached :image

    has_many :order_products
    has_many :orders, through: :order_products

    paginates_per 20

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "price_cents", "updated_at"]
      end
    def self.ransackable_associations(auth_object = nil)
        ["flower_colour", "flower_type", "order_products", "orders"]
    end
end
