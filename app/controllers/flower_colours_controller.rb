class FlowerColoursController < ApplicationController
  def index
    #@colours = FlowerColour.all
    @colours = FlowerColour.order(:colour_name).page params[:page]
  end

  def show
    @colour = FlowerColour.find(params[:id])
  end
end
