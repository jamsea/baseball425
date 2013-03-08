class Team < ActiveRecord::Base
  attr_accessible :abbreviation, :city, :division, :league, :team_name
end
