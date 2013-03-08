class Player < ActiveRecord::Base
  attr_accessible :date_of_birth, :first_name, :height, :last_name, :weight
end
