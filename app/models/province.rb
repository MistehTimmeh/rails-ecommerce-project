class Province < ApplicationRecord
    has_many :users

    validates :province_name, :province_shortcode, :hst_rate, :gst_rate, :pst_rate, presence: true
    validates :province_name, :province_shortcode, uniqueness: true
    validates :hst_rate, :gst_rate, :pst_rate, numericality: true

    def self.ransackable_associations(auth_object = nil)
        ["users"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "province_name", "province_shortcode", "pst_rate", "gst_rate", "hst_rate", "updated_at"]
    end
end
