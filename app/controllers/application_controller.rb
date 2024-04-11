class ApplicationController < ActionController::Base

    #makes stuff happen first
    before_action :initialize_session

    helper_method :cart

    private
    def initialize_session
        session[:shopping_cart] ||= [] #empty array of product ids
    end

    def cart
        Product.find(session[:shopping_cart])
    end
end
