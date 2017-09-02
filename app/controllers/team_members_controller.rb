class TeamMembersController < ApplicationController
  layout "teams"
  before_action :set_team_member, only: [:update]

  def invitations
    @invitations = current_user.invitations
  end

  def new
    @team_member = TeamMember.new
    @user = User.find(params[:id])
    @teams = current_user.available_teams
  end

  def create
    @team_member = TeamMember.new(team_member_params.merge(status: 'invited'))
    if @team_member.save
      redirect_to users_path, flash: {success: 'Invitation sent!'}
    else
      flash[:error] = @team_member.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    @team_member = current_user.team_members.find_by_id(params[:id])
    if @team_member.present?
      if @team_member.update_invitation(params[:status])
        flash[:success] = "Invitation processed!"
      else
        flash[:error] = @team_member.errors.full_messages.to_sentence
      end
      redirect_back fallback_location: teams_path
    else
      flash[:error] = "Invitation doesn't exist!"
      redirect_back fallback_location: teams_path
    end
  end

  private
  def team_member_params
    params.require(:team_member).permit(:user_id, :team_id)
  end

  def set_team_member
    @team_member = TeamMember.find(params[:id])
  end
end
