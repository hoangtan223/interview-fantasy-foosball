class TeamsController < ApplicationController
  before_action :require_login
  def index
  end

  def new
    @team = Team.new
  end

  def create
    if current_user.team.present?
      flash[:error] = "You already has team!"
      redirect_back(fallback_location: root_path)
    else
      @team = Team.new(team_params)
      @team.members << current_user
      if @team.save
        redirect_to root_path, flash: {success: 'Team created!'}
      else
        flash[:error] = @team.errors.full_messages.to_sentence
        render 'new'
      end
    end
  end

  private
  def team_params
    params.require(:team).permit(:name, :image_url)
  end
end
