class GamesController < ApplicationController

  def new
  end

  def create
  end

  def show
    @game = Game.new
    respond_to do |format|
      format.html { render :show }
      format.js { render :json => @game }
    end
    #render :json => Game.new
  end

end
