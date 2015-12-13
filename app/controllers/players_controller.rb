class PlayersController < ApplicationController

  def index
    @all_players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def players_by_bowling_type
    @players_by_bowling_type = Player.where(:bowling_type => params[:bowling_type])
  end

  def players_by_bowling_hand
    @players_by_bowling_hand = Player.where(:bowling_hand => params[:bowling_hand])
  end

  def players_by_batting_hand
    @players_by_batting_hand = Player.where(:batting_hand => params[:batting_hand])
  end

  def keepers
    is_keeper = params[:is_keeper]
    if is_keeper == 'keeper'
      @players = Player.keepers
    else
      @players = Player.not_keepers
    end
  end

end