class FlowerTypesController < ApplicationController
  def index
    @types = FlowerType.all
  end

  def show
    @type = FlowerType.find(params[:id])
  end
end