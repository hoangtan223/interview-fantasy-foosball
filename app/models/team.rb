class Team < ApplicationRecord
  validates_presence_of :name
  has_many :team_members, dependent: :destroy
  has_many :users, through: :team_members
end
