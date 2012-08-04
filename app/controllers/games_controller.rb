class GamesController < ApplicationController

  def new
  end

  def create
  end

  def show
    render :json => Game.new
  end

end
