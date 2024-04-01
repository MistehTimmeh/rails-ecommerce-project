class FlowerTypeController < ApplicationController
  def index
    @types = FlowerColour.all
  end

  def show
    @type = FlowerColour.find(params[:id])
  end
end