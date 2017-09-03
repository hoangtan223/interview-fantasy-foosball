class Game < ApplicationRecord
  validates_presence_of :home_point, :away_point
  validates :home_point, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :away_point, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validate :not_a_draw_result, :game_number_per_match

  after_create :check_if_finish_match

  belongs_to :match

  def not_a_draw_result
    if home_point == away_point
      errors.add(:result, "cannot be draw")
    end
  end

  def check_if_finish_match
    if self.match.games.count > 1
      home_win_count = match.home_win_count
      if home_win_count == 0 || home_win_count == 2
        self.match.update(status: 'finished', is_home_win: home_win_count == 2 ? true : false)
      end
    end
  end

  def game_number_per_match
    if match.is_finish?
      errors.add(:match, "is finished!")
    end
  end
end
