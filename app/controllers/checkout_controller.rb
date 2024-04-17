class CheckoutController < ApplicationController
    def create
        #establish connection with stripe, send user to payment screen
        #@product = Product.find(params[:product_id])

        #if @product.nil?
        #    redirect_to root_path
        #    return
        #end

        cart = session[:shopping_cart]
        line_items = []

        cart.each.with_index do |product, index|
            line_items[index] = {
                quantity: 1,
                price_data: {
                    unit_amount: product.price_cents,
                    currency: "cad",
                    product_data: {
                        name: "#{product.flower_colour.colour_name} #{product.flower_type.type_name}".titleize,
                        description: product.description
                    }
                }
            }
        end

        #Use database tax values instead of hardcoded values
        #Separate cases into unique values to account for each province/territory
        case current_user.province_id
        when 1, 6 ,8, 13
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.05).to_i,
                    product_data: {
                        name: "GST",
                        description: "Goods and Services Tax"
                    }
                }
            }
        when 2, 3
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.05).to_i,
                    product_data: {
                        name: "GST",
                        description: "Goods and Services Tax"
                    }
                }
            }
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.07).to_i,
                    product_data: {
                        name: "PST",
                        description: "Provincial Sales Tax"
                    }
                }
            }
        when 4, 5, 7, 10
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.15).to_i,
                    product_data: {
                        name: "HST",
                        description: "Harmonized Tax"
                    }
                }
            }
        when 9
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.13).to_i,
                    product_data: {
                        name: "HST",
                        description: "Harmonized Tax"
                    }
                }
            }
        when 11
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.05).to_i,
                    product_data: {
                        name: "GST",
                        description: "Goods and Services Tax"
                    }
                }
            }
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.07).to_i,
                    product_data: {
                        name: "PST",
                        description: "Provincial Sales Tax"
                    }
                }
            }
        when 12
            line_items << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (@product.price_cents * 0.05).to_i,
                    product_data: {
                        name: "GST",
                        description: "Goods and Services Tax"
                    }
                }
            }
        end



        @session = Stripe::Checkout::Session.create(
            payment_method_types: ["card"],
            success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: checkout_cancel_url,
            mode: "payment",
            line_items: [
                {
                    quantity: 1,
                    price_data: {
                        unit_amount: @product.price_cents,
                        currency: "cad",
                        product_data: {
                            name: "#{@product.flower_colour.colour_name} #{@product.flower_type.type_name}".titleize,
                            description: @product.description
                        }
                    }
                },
                {
                    quantity: 1,
                    price_data: {
                        currency: "cad",
                        unit_amount: (@product.price_cents * 0.05).to_i,
                        product_data: {
                            name: "GST",
                            description: "Goods and Services Tax"
                        }
                    }
                },
                {
                    quantity: 1,
                    price_data: {
                        currency: "cad",
                        unit_amount: (@product.price_cents * 0.07).to_i,
                        product_data: {
                            name: "PST",
                            description: "Provincial Sales Tax"
                        }
                    }
                },
            ]
        )


        #respond_to do |format|
        #    format.js
        #end

        redirect_to @session.url, allow_other_host: true

    end

    def success
        #purchase was successful
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    end

    def cancel
        #purchase was canceled

    end
end
