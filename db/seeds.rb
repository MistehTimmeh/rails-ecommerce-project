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
            item_price:                     15,
            description: "This #{flower["color one"]} #{flower["name"]} is native to #{flower["place of origin"]}, can grow to a height of #{flower["height (cm)"]} and is used to a #{flower["climate"]} climate.",
        )
    end

    if color_two && color_two.valid? && type && type.valid?
        product_two = Product.create(
            flower_colour_id:               color_two.id,
            flower_type_id:                 type.id,
            item_price:                     15,
            description: "This #{flower["color two"]} #{flower["name"]} is native to #{flower["place of origin"]}, can grow to a height of #{flower["height (cm)"]} and is used to a #{flower["climate"]} climate.",
        )
    end

    if color_three && color_three.valid? && type && type.valid?
        product_three = Product.create(
            flower_colour_id:               color_three.id,
            flower_type_id:                 type.id,
            item_price:                     15,
            description: "This #{flower["color three"]} #{flower["name"]} is native to #{flower["place of origin"]}, can grow to a height of #{flower["height (cm)"]} and is used to a #{flower["climate"]} climate.",
        )
    end


end


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?