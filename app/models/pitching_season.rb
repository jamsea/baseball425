class PitchingSeason < ActiveRecord::Base
  belongs_to :player
  attr_accessible :babip, :bb, :bb_percent, :bk, :bs, :cg, :er, :era, :gp, :gs, :h, :hbp, :hld, :hr, :ibb, :jersey_number, :k, :k_percent, :l, :outs, :outs, :r, :season_order, :sho, :sv, :tbf, :team, :w, :whip, :wp, :player_id
  
  def self.search(search)
    if search
      find(:all, :conditions => ['first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
end
