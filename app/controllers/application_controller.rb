class ApplicationController < ActionController::Base

    #makes stuff happen first
    before_action :configure_permitted_parameters, if:  :devise_controller?
    before_action :initialize_session

    helper_method :cart

    protected

      def configure_permitted_parameters

        devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id, :address, :city, :postal_code])

      end

    private
    def initialize_session
        session[:shopping_cart] ||= [] #empty array of product ids
        session[:signed_in] ||= false #false for not signed in
    end

    def cart
        Product.find(session[:shopping_cart])
    end
end
