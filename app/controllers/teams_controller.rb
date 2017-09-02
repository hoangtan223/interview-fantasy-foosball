class TeamsController < ApplicationController
  before_action :require_login

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.team_members.build(user: current_user, status: 'team_owner')
    if @team.save
      redirect_to my_teams_path, flash: {success: 'Team created!'}
    else
      flash[:error] = @team.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def my_teams
    @teams = current_user.teams
  end

  private
  def team_params
    params.require(:team).permit(:name, :image_url)
  end
end
