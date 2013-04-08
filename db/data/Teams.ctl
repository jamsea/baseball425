load data
 infile '/home/stancza/60-425/Teams.csv'
 into table Teams
 fields terminated by "," optionally enclosed by '"'		  
 (abbreviation, city, teamName, league, division terminated by whitespace)