class Team < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :team_members, dependent: :destroy
  has_many :users, through: :team_members
  has_many :home_matches, class_name: 'Match', foreign_key: 'home_team_id'
  has_many :away_matches, class_name: 'Match', foreign_key: 'away_team_id'

  def all_matches
    home_matches.or(away_matches)
  end
end
