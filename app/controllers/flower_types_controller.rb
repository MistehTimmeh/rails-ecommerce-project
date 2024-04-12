class FlowerTypesController < ApplicationController
  def index
    #@types = FlowerType.all
    @types = FlowerType.order(:type_name).page params[:page]
  end

  def show
    @type = FlowerType.find(params[:id])
  end
end