module MatchesHelper
  def get_match_point(match)
    game_count = match.games.count
    if game_count == 0
      "0 - 0"
    else
      home_match_point = match.games.where('home_point > away_point').count
      away_match_point = game_count - home_match_point
      "#{home_match_point} - #{away_match_point}"
    end
  end
end
