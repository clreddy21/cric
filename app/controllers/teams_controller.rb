class PlayersController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(:includes => :players)
  end
end
