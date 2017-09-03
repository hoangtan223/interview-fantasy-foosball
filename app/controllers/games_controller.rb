class GamesController < ApplicationController
  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:success] = "Game result updated!"
    else
      flash[:error] = @game.errors.full_messages.to_sentence
    end
    redirect_back fallback_location: matches_path(status: 'started')
  end

  private
  def game_params
    params.require(:game).permit(:match_id, :home_point, :away_point)
  end
end
