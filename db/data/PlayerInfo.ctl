load data
 infile '/home/stancza/60-425/PlayerInfo.csv'
 into table PlayerInfo
 fields terminated by "," optionally enclosed by '"'		  
 (playerID, firstName, lastName, dateOfBirth, height, weight terminated by whitespace)