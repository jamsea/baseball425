class Team < ActiveRecord::Base
  has_many :players
  attr_accessible :abbreviation, :city, :division, :league, :team_name
end
