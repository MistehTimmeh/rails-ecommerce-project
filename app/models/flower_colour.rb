class FlowerColour < ApplicationRecord
    has_many :products

    validates :colour_name, presence: true
    validates :colour_name, uniqueness: true

    paginates_per 20

    def display_name
        self.colour_name # or whatever column you want
    end

    def self.ransackable_associations(auth_object = nil)
        ["products"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["colour_name", "created_at", "id", "id_value", "updated_at"]
    end
end
