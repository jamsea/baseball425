class BattingSeason < ActiveRecord::Base
  belongs_to :player
  attr_accessible :ab, :ba, :bb, :bb_percent, :cs, :doubles, :gidp, :gp, :hbp, :hr, :ibb, :jersey_number, :k_percent, :obp, :ops, :pa, :position, :r, :rbi, :sb, :season_order, :sf, :sh, :singles, :slg, :so, :tb, :team, :triples, :player_id
end
