load data
 infile '/home/stancza/60-425/PlayerPitchingSeason.csv'
 into table PlayerPitchingSeason
 fields terminated by ","
 trailing nullcols
 (playerID, team, seasonOrder, GP, GS, W, L, SV, IP, OUTS, TBF, H, R, ER, HR, K, BB, IBB, HBP, CG, SHO, WP, BK terminated by whitespace)