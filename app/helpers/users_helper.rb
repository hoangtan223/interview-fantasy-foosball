module UsersHelper
  def team_names(user)
    if user.teams.present?
      user.teams.map(&:name).join(', ')
    else
      "Free Player"
    end
  end
end
