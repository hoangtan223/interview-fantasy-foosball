class TeamMember < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum status: {team_owner: 0, invited: 1, accepted: 2}
end
