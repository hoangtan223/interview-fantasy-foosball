require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:team) { create(:team) }

  it 'should not allow home team to be the same as away team' do
    match = Match.new(home_team: team, away_team: team)

    expect(match.save).to be false
    expect(match.errors.full_messages).to include "Home team cannot be the same as away team"
  end
end
