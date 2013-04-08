# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

#Teams

CSV.foreach('db/data/Teams.csv', :headers => true) do |row|
  Team.create!(row.to_hash)
end

#Teams

CSV.foreach('db/data/PlayerBattingSeason.csv', :headers => true) do |row|
  BattingSeason.create!(row.to_hash)
end

#Teams

CSV.foreach('db/data/PlayerPitchingSeason.csv', :headers => true) do |row|
  PitchingSeason.create!(row.to_hash)
end

#Teams

CSV.foreach('db/data/PlayerInfo.csv', :headers => true) do |row|
  Player.create!(row.to_hash)
end
