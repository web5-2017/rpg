class DicesController < ApplicationController

  def cast_dice
    dice = Dice.new(Integer(params[:type]))

    if params[:amount]
      render json: dice.casts(Integer(params[:amount]))
    else
      render json: dice.cast
    end
  end

end
