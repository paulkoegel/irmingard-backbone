class GamesController < ApplicationController

  def new
  end

  def create
  end

  def show
    @game = Game.new
    respond_to do |format|
      format.html { render 'shared/nothing' }
      format.js { render :json => @game }
    end
  end

end
