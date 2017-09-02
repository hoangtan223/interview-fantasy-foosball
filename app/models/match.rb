class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  scope :invited_matches, -> { where(status: 0) }
  scope :started_matches, -> { where(status: 1) }
  scope :finished_matches, -> { where(status: 2) }

  enum status: {invited: 0,started: 1, finished: 2}
end
