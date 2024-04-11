class CartController < ApplicationController
    def index
        @cart = cart
    end

    def create
        logger.debug("Adding #{params[:id]} to cart.")
        id = params[:id].to_i
        session[:shopping_cart] << id unless session[:shopping_cart].include?(id)
        product = Product.find(id)
        flash[:notice] = "Added #{product.flower_colour.colour_name} #{product.flower_type.type_name} to cart."
        redirect_to root_path
    end

    def destroy
        id = params[:id].to_i
        session[:shopping_cart].delete(id)
        product = Product.find(id)
        flash[:notice] = "Removed #{product.flower_colour.colour_name} #{product.flower_type.type_name} from cart."
        redirect_to root_path
    end

    def update_quantity

    end
end
