class Province < ApplicationRecord
    has_many :users

    validates :province_name, :province_shortcode, :province_taxes, presence: true
    validates :province_name, :province_shortcode, uniqueness: true
    validates :province_taxes, numericality: true

    def self.ransackable_associations(auth_object = nil)
        ["users"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "province_name", "province_shortcode", "province_taxes", "updated_at"]
    end
end
