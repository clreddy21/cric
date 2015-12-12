class PlayersController < ApplicationController

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def players_by_bowling_type
    @players = Player.where(:bowling_type => params[:bowling_type])
  end

  def players_by_bowling_hand
    @players = Player.where(:bowling_hand => params[:bowling_hand])
  end

  def players_by_batting_hand
    @players = Player.where(:batting_hand => params[:batting_hand])
  end

  def keepers
    @players = Player.keepers
  end

end