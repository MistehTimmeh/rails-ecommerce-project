class ProductsController < ApplicationController
  def index
    #@products = Product.all
    @products = Product.order(:id).page params[:page]
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.all
    search = params[:keyword]

    if params[:category] == "products"
      @products = @products.includes(:flower_type, :flower_colour).where("description LIKE ? OR flower_types.type_name LIKE ? OR flower_colours.colour_name LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%").references(:flower_type, :flower_colour)
    end

    if params[:category] == "type_name"
      @products = @products.includes(:flower_type).where("description LIKE ? OR flower_types.type_name LIKE ?", "%#{search}%", "%#{search}%").references(:flower_type)
    end

    if params[:category] == "colour_name"
      @products = @products.includes(:flower_colour).where("description LIKE ? OR flower_colours.colour_name LIKE ?", "%#{search}%", "%#{search}%").references(:flower_colour)
    end
  end
end
