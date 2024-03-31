class User < ApplicationRecord
    belongs_to :province

    has_many :orders

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "is_admin", "password", "updated_at", "username"]
    end
end
