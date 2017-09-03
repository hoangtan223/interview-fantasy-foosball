class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :start_match]
  def index
    @matches = current_user.all_matches_with_status(params[:status])
  end

  def show
  end

  def new
    @match = Match.new
    @user_teams = current_user.teams
    @opponent_teams = Team.all_except(@user_teams.map(&:id))
  end

  def create
    if current_user.teams.map(&:id).include? match_params[:home_team_id].to_i
      @match = Match.new(match_params.merge(status: 'invited'))
      if @match.save
        redirect_to matches_path(status: 'invited'),flash: {success: 'Invitation is sent to opponent team'}
      else
        flash[:error] = @match.errors.full_messages.to_sentence
        @user_teams = current_user.teams
        @opponent_teams = Team.except(@user_teams)
        render 'new'
      end
    else
      @match = Match.new
      @user_teams = current_user.teams
      @opponent_teams = Team.except(@user_teams)
      flash[:error] = 'You are not member of the home team'
      render 'new'
    end
  end

  def start_match
    if current_user.is_away_team?(@match)
      if @match.update(status: 'started')
        redirect_to matches_path(status: 'started'), flash: {success: "Match #{@match.id} started"}
      else
        flash[:error] = @match.errors.full_messages.to_sentence
        redirect_back fallback_location: matches_path(status: 'invited')
      end
    else
      flash[:error] = "You are not away team's member to start this game"
      redirect_back fallback_location: matches_path(status: 'invited')
    end
  end

  private
  def match_params
    params.require(:match).permit(:home_team_id, :away_team_id)
  end

  def set_match
    @match = Match.find(params[:id])
  end
end
