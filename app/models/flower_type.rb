class FlowerType < ApplicationRecord
    has_many :products

    def display_name
        self.type_name # or whatever column you want
    end

    def self.ransackable_associations(auth_object = nil)
        ["products"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "type_name", "updated_at"]
    end
end
