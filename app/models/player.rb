class Player < ActiveRecord::Base

  has_many :team_players
  has_many :teams, through: :team_players

  scope :keepers, -> { where keeper: true }
  scope :not_keepers, -> { where keeper: false }

end
