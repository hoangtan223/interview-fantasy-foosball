class TeamMember < ApplicationRecord
  belongs_to :user
  belongs_to :team
  validate :team_is_not_full

  enum status: {team_owner: 0, invited: 1, accepted: 2}

  def team_is_not_full
    if TeamMember.where(team_id: self.team_id).count == 2
      errors.add(:team, "is full")
    end
  end
end
