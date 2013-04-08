require 'csv'    

CSV.foreach('data/Teams.csv', :headers => true) do |row|
  Teams.create!(row.to_hash)
end