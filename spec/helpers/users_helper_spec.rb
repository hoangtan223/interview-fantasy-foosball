require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  let(:users) { create_list(:user, 5) }
  let(:teams) { create_list(:team, 3) }

  describe "#team_names" do
    it 'return "Free Player" when user in no team' do
      expect(helper.team_names(users.first)).to eq "Free Player"
    end

    it 'return 1 team name when user in 1 team' do
      user = users.first
      TeamMember.create(user: user, team: teams.first)

      expect(helper.team_names(user)).to eq(teams.first.name)
    end

    it 'return multiple names when user in multiple teams' do
      user = users.first
      TeamMember.create(user: user, team: teams.first)
      TeamMember.create(user: user, team: teams.last)

      expect(helper.team_names(user)).to eq("#{teams.first.name}, #{teams.last.name}")
    end
  end
end
