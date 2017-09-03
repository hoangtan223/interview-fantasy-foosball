class TeamsController < ApplicationController
  before_action :require_login
  before_action :get_notification_count, except: [:create]

  def show
    @team = Team.find(params[:id])
  end

  def index
    @page_title = "All Teams"
    @teams = Team.all.sort_by(&:win_rate).reverse
  end

  def new
    @page_title = "New Team"
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
    @page_title = "My Teams"
    @teams = current_user.teams.sort_by(&:win_rate).reverse
  end

  private
  def team_params
    params.require(:team).permit(:name, :image_url)
  end

  def get_notification_count
    @invitation_count = current_user.invitations.count
  end
end
