class GamesController < ApplicationController

  def new
  end

  def create
  end

  def show
    @game = Game.new
    image_names = %w(back.gif 10_of_clubs.gif 10_of_diamonds.gif 10_of_hearts.gif 10_of_spades.gif 2_of_clubs.gif 2_of_diamonds.gif 2_of_hearts.gif 2_of_spades.gif 3_of_clubs.gif 3_of_diamonds.gif 3_of_hearts.gif 3_of_spades.gif 4_of_clubs.gif 4_of_diamonds.gif 4_of_hearts.gif 4_of_spades.gif 5_of_clubs.gif 5_of_diamonds.gif 5_of_hearts.gif 5_of_spades.gif 6_of_clubs.gif 6_of_diamonds.gif 6_of_hearts.gif 6_of_spades.gif 7_of_clubs.gif 7_of_diamonds.gif 7_of_hearts.gif 7_of_spades.gif 8_of_clubs.gif 8_of_diamonds.gif 8_of_hearts.gif 8_of_spades.gif 9_of_clubs.gif 9_of_diamonds.gif 9_of_hearts.gif 9_of_spades.gif ace_of_clubs.gif ace_of_diamonds.gif ace_of_hearts.gif ace_of_spades.gif jack_of_clubs.gif jack_of_diamonds.gif jack_of_hearts.gif jack_of_spades.gif king_of_clubs.gif king_of_diamonds.gif king_of_hearts.gif king_of_spades.gif queen_of_clubs.gif queen_of_diamonds.gif queen_of_hearts.gif queen_of_spades.gif)
    # creates a Hash in the form of {:10_of_clubs => '/assets/10_of_clubs-f1fd3891f1d20d5f46d37e7972d3cd52.gif', ... }
    gon.image_paths = image_names.map{|image_name| {:"#{image_name.split('.')[0]}" => ActionController::Base.helpers.asset_path(image_name)} }.inject({}){|memo, el| memo.merge(el)}

    respond_to do |format|
      format.html { render 'shared/nothing' }
      format.js { render :json => @game }
    end
  end

end
