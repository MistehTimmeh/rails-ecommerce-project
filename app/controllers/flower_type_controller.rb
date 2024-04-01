class FlowerTypeController < ApplicationController
  def index
    @types = FlowerColour.all
  end

  def show
    @type = FlowerColour.find(:id)
  end
end