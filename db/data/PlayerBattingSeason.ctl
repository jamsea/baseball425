load data
 infile '/home/stancza/60-425/PlayerBattingSeason.csv'
 into table PlayerBattingSeason
 fields terminated by ","
 trailing nullcols
 (playerID, team, seasonOrder, GP, PA, AB, singles, doubles, triples, HR, R, RBI, BB, IBB, SO, HBP, SF, SH, GIDP, SB, CS terminated by whitespace)