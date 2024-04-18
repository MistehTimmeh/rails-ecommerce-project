class CheckoutController < ApplicationController
    def create
        #establish connection with stripe, send user to payment screen
        #@product = Product.find(params[:product_id])

        #if @product.nil?
        #    redirect_to root_path
        #    return
        #end
        @provinces = Province.all
        user_cart = cart
        total_price = 0
        line_items_array = []
        current_user_province = @provinces.where(id: current_user.province_id).first
        logger.debug("Current user: #{current_user}")
        logger.debug("Current user province id: #{current_user.province_id}")
        logger.debug("Current user province id: #{current_user_province}")


        user_cart.each.with_index do |product, index|
            total_price = total_price + product.price_cents

            line_items_array[index] = {
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

        if not(current_user_province.gst_rate == 0)
            line_items_array << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (total_price * current_user_province.gst_rate).to_i,
                    product_data: {
                        name: "GST",
                        description: "Goods and Services Tax"
                    }
                }
            }
        end

        if not(current_user_province.pst_rate == 0)
            line_items_array << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (total_price * current_user_province.pst_rate).to_i,
                    product_data: {
                        name: "PST",
                        description: "Provincial Sales Tax"
                    }
                }
            }
        end

        if not(current_user_province.hst_rate == 0)
            line_items_array << {
                quantity: 1,
                price_data: {
                    currency: "cad",
                    unit_amount: (total_price * current_user_province.hst_rate).to_i,
                    product_data: {
                        name: "HST",
                        description: "Harmonized Tax"
                    }
                }
            }
        end

        @session = Stripe::Checkout::Session.create(
            payment_method_types: ["card"],
            success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: checkout_cancel_url,
            mode: "payment",
            line_items: line_items_array
        )


        #respond_to do |format|
        #    format.js
        #end

        redirect_to @session.url, allow_other_host: true

    end

    def success
        #purchase was successful
        @provinces = Province.all
        @current_user_province = @provinces.where(id: current_user.province_id).first
        @user_cart = cart
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

        current_order = Order.create(
            order_date: Time.now,
            order_price: @session[:amount_total],
            stripe_payment_id: params[:session_id],
            user_id: current_user.id
        )

        @user_cart.each do |product|
            OrderProduct.create(
                product_quantity: 1,
                product_total_price: product.price_cents + (@current_user_province.gst_rate * product.price_cents) + (@current_user_province.hst_rate * product.price_cents) + (@current_user_province.pst_rate * product.price_cents),
                product_id: product.id,
                order_id: current_order.id
            )
        end

        session[:shopping_cart] = [] #empty array of product ids
    end

    def cancel
        #purchase was canceled

    end
end
