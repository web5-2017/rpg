class HistoriesController < ApplicationController

  def index
    @histories = History.order :title
  end

  def show
    @history = History.find params[:id]
  end

end
