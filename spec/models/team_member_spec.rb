require 'rails_helper'

RSpec.describe TeamMember, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:team) }

  describe "create new team member" do
    let(:users) { create_list(:user, 5) }
    let(:team) { create(:team) }
    let(:full_team) do
      team.team_members.create(user: users.first, status: 'team_owner')
      team.team_members.create(user: users.last, status: 'accepted')
      team
    end

    it 'should validate when team is full' do
      new_user = create(:user)
      team_member = full_team.team_members.build(user: new_user)
      expect(team_member.save).to be false
      expect(team_member.errors.full_messages).to include("Team is full")
    end

  end
end
