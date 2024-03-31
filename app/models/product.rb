class Product < ApplicationRecord
    belongs_to :flower_colour
    belongs_to :flower_type

    has_many :order_products
    has_many :orders, through: :order_products
end
