class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name
  has_many :team_members, dependent: :destroy
  has_many :teams, through: :team_members

  scope :all_except, ->(user) { where.not(id: user) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def image_url_or_default
    "https://www.shareicon.net/data/512x512/2016/06/30/788946_people_512x512.png"
  end

  def available_teams
    teams.joins(:team_members).group('teams.id').having('count(team_members.team_id) < 2')
  end
end
