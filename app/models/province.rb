class Province < ApplicationRecord
    has_many :users

    def self.ransackable_associations(auth_object = nil)
        ["users"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "province_name", "province_shortcode", "province_taxes", "updated_at"]
    end
end
