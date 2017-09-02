class TeamMember < ApplicationRecord
  belongs_to :user
  belongs_to :team
  validate :team_is_not_full, on: :create

  enum status: {team_owner: 0, invited: 1, accepted: 2}

  def team_is_not_full
    if TeamMember.where(team_id: self.team_id).count == 2
      errors.add(:team, "is full")
    end
  end

  def update_invitation(action)
    case action
    when "accept"
      self.update(status: 'accepted')
    when "decline"
      self.destroy
    else
      errors.add(:action, "is invalid!")
      false
    end
  end
end
