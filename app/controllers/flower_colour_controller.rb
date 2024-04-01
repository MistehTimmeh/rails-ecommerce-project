class FlowerColourController < ApplicationController
  def index
    @colours = FlowerColour.all
  end

  def show
    @colour = FlowerColour.find(:id)
  end
end
