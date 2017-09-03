class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  has_many :games, dependent: :destroy

  scope :invited_matches, -> { where(status: 0) }
  scope :started_matches, -> { where(status: 1) }
  scope :finished_matches, -> { where(status: 2) }

  enum status: {invited: 0,started: 1, finished: 2}

  def home_win_count
    games.where('home_point > away_point').count
  end

  def is_finish?
    games.count > 1 && (home_win_count == 2 || home_win_count == 0)
  end

  def winner
    home_win_count == 2 ? home_team : away_team
  end
end
