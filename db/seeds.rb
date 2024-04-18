# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

AdminUser.delete_all
Province.delete_all
Product.delete_all
FlowerColour.delete_all
FlowerType.delete_all

filename = Rails.root.join("db/flowers.csv")

csv_data = File.read(filename)
flowers = CSV.parse(csv_data, headers: true, encoding: "utf-8")

flowers.each do |flower|
    if flower["color one"] != "NONE"
        color_one = FlowerColour.find_or_create_by(colour_name: flower["color one"])
    end

    if flower["color two"] != "NONE"
        color_two = FlowerColour.find_or_create_by(colour_name: flower["color two"])
    end

    if flower["color three"] != "NONE"
        color_three = FlowerColour.find_or_create_by(colour_name: flower["color three"])
    end

    type = FlowerType.find_or_create_by(type_name: flower["name"])

    if color_one && color_one.valid? && type && type.valid?
        product_one = Product.create(
            flower_colour_id:               color_one.id,
            flower_type_id:                 type.id,
            price_cents:                     1500.to_i,
            description: "This #{flower["color one"]} #{flower["name"]} is native to #{flower["place of origin"]}, can grow to a height of #{flower["height (cm)"]} centimeters and is used to a #{flower["climate"]} climate.",
        )
        #query_one = URI.encode_www_form_component([product_one.flower_colour.colour_name, product_one.flower_type.type_name].join(","))
        #downloaded_image_one = URI.open("https://source.unsplash.com/400x400/?#{query_one}")
        #product_one.image.attach(io:downloaded_image_one, filename: "m-#{[product_one.flower_colour.colour_name, product_one.flower_type.type_name].join("-")}.jpg")
        #sleep(10)
    end

    if color_two && color_two.valid? && type && type.valid?
        product_two = Product.create(
            flower_colour_id:               color_two.id,
            flower_type_id:                 type.id,
            price_cents:                     1500.to_i,
            description: "This #{flower["color two"]} #{flower["name"]} is native to #{flower["place of origin"]}, can grow to a height of #{flower["height (cm)"]} centimeters and is used to a #{flower["climate"]} climate.",
        )
        #query_two = URI.encode_www_form_component([product_two.flower_colour.colour_name, product_two.flower_type.type_name].join(","))
        #downloaded_image_two = URI.open("https://source.unsplash.com/400x400/?#{query_two}")
        #product_two.image.attach(io:downloaded_image_two, filename: "m-#{[product_two.flower_colour.colour_name, product_two.flower_type.type_name].join("-")}.jpg")
        #sleep(10)
    end

    if color_three && color_three.valid? && type && type.valid?
        product_three = Product.create(
            flower_colour_id:               color_three.id,
            flower_type_id:                 type.id,
            price_cents:                     1500.to_i,
            description: "This #{flower["color three"]} #{flower["name"]} is native to #{flower["place of origin"]}, can grow to a height of #{flower["height (cm)"]} centimeters and is used to a #{flower["climate"]} climate.",
        )
        #query_three = URI.encode_www_form_component([product_three.flower_colour.colour_name, product_three.flower_type.type_name].join(","))
        #downloaded_image_three = URI.open("https://source.unsplash.com/400x400/?#{query_three}")
        #product_three.image.attach(io:downloaded_image_three, filename: "m-#{[product_three.flower_colour.colour_name, product_three.flower_type.type_name].join("-")}.jpg")
        #sleep(10)
    end


end
provinces =  ["Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan", "Yukon"]
shortcodes = ["AB", "BC", "MB", "NB", "NL", "NT", "NS", "NU", "ON", "PE", "QC", "SK", "YT"]
pst_rates = [0, 0.07, 0.07, 0, 0, 0, 0, 0, 0, 0, 0.09975, 0.06, 0]
gst_rates = [0.05, 0.05, 0.05, 0, 0, 0.05, 0, 0.05, 0, 0, 0.05, 0.05, 0.05]
hst_rates = [0, 0, 0, 0.15, 0.15, 0, 0.15, 0, 0.13, 0.15, 0, 0, 0]
provinces.each.with_index do |province, index|
    Province.create!(province_name: province, province_shortcode: shortcodes[index], pst_rate: pst_rates[index], gst_rate: gst_rates[index], hst_rate: hst_rates[index])
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?