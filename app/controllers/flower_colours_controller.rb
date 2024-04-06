class FlowerColoursController < ApplicationController
  def index
    @colours = FlowerColour.all
  end

  def show
    @colour = FlowerColour.find(params[:id])
  end
end
