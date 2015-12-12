class Team < ActiveRecord::Base

  has_many :team_players
  has_many :players, through: :team_players

  validates :name, uniqueness: true, presence:true

end
