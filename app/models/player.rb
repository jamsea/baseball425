class Player < ActiveRecord::Base
  has_one :pitching_season
  has_one :batting_season
  belongs_to :team
  attr_accessible :date_of_birth, :first_name, :height, :last_name, :weight, :team_id
  
  def full_name
    first_name + ' ' + last_name
  end
end
