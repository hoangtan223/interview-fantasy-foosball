class Team < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :team_members, dependent: :destroy
  has_many :users, through: :team_members
  has_many :home_matches, class_name: 'Match', foreign_key: 'home_team_id'
  has_many :away_matches, class_name: 'Match', foreign_key: 'away_team_id'

  mount_uploader :image_url, AvatarUploader

  scope :all_except, ->(team) { where.not(id: team) }
  def all_matches
    home_matches.or(away_matches)
  end

  def all_completed_match
    all_matches.where(status: 'finished')
  end

  def win_matches
    home_matches.where(is_home_win: true).or(away_matches.where(is_home_win: false))
  end

  def win_rate
    if all_completed_match.count == 0
      0
    else
      (win_matches.count.to_f / all_completed_match.count) * 100
    end
  end

  def image_url_or_default
    self.image_url.present? ? image_url : 'https://i.pinimg.com/originals/fb/63/a7/fb63a70f631c33e0b457c82db41e0f33.jpg'
  end
end
