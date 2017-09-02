class MatchesController < ApplicationController
  def index
    @matches = current_user.all_matches
  end

  def new
  end

  def create
  end
end
