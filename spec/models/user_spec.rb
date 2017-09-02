require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  let(:users) { create_list(:user, 5) }
  let(:team) { create(:team) }
  let(:full_team) do
    team.team_members.create(user: users.first, status: 'team_owner')
    team.team_members.create(user: users.last, status: 'accepted')
    team
  end

  describe "#available_teams" do
    it 'return empty array when user has no team' do
      expect(users.first.available_teams).to match_array []
    end

    it 'should return only teams that has less than 2 members' do
      full_team
      new_team = Team.create(name: 'hello')
      new_team.team_members.create(user: users.first)
      expect(users.first.available_teams).to match_array [new_team]
    end
  end
end
