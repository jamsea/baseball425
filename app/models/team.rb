class Team < ActiveRecord::Base
  has_many :players
  attr_accessible :abbreviation, :city, :division, :league, :team_name

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
