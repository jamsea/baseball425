---------- TABLE CREATION ----------

CREATE TABLE Teams (
	teamID int PRIMARY KEY,
	abbreviation varchar(3) PRIMARY KEY,
	city varchar(12) NOT NULL, -- longest value in this column is 'San Francisco'
	teamName varchar(13) NOT NULL, -- longest value in this column is 'Diamondbacks'
	league varchar(2) NOT NULL, -- either 'AL' or 'NL'
	division varchar(7) NOT NULL -- either 'East', 'Central', or 'West'
);

CREATE TABLE PlayerInfo (
	playerID int PRIMARY KEY,
	firstName varchar(15) NOT NULL,
	lastName varchar(15) NOT NULL,
	dateOfBirth date NOT NULL,
	height int NOT NULL,
	weight int NOT NULL
);

CREATE TABLE PlayerBattingSeason (
	playerID int NOT NULL,
	team varchar(3) NOT NULL,
	jerseyNumber int NOT NULL,
	seasonOrder int NOT NULL,
	position varchar(10) NOT NULL,
	GP int NOT NULL,
	PA int,
	AB int NOT NULL,
	singles int NOT NULL,
	doubles int NOT NULL,
	triples int NOT NULL,
	HR int NOT NULL,
	R int NOT NULL,
	RBI int NOT NULL,
	BB int NOT NULL,
	IBB int NOT NULL,
	SO int NOT NULL,
	HBP int NOT NULL,
	SF int NOT NULL,
	SH int NOT NULL,
	GIDP int NOT NULL,
	SB int NOT NULL,
	CS int NOT NULL,
	CONSTRAINT pk_pbs PRIMARY KEY(playerID, team, seasonOrder),
	CONSTRAINT fk_pbs_player FOREIGN KEY (playerID) REFERENCES PlayerInfo(playerID),
	CONSTRAINT fk_pbs_team FOREIGN KEY (team) REFERENCES Teams(abbreviation)
);

CREATE TABLE PlayerPitchingSeason (
	playerID int NOT NULL,
	team varchar(3) NOT NULL,
	jerseyNumber int NOT NULL,
	seasonOrder int NOT NULL,
	GP int NOT NULL,
	GS int NOT NULL,
	W int NOT NULL,
	L int NOT NULL,
	SV int NOT NULL,
	BS int NOT NULL,
	HLD int NOT NULL,
	OUTS int NOT NULL,
	TBF int NOT NULL,
	H int NOT NULL,
	R int NOT NULL,
	ER int NOT NULL,
	HR int NOT NULL,
	K int NOT NULL,
	BB int NOT NULL,
	IBB int NOT NULL,
	HBP int NOT NULL,
	CG int NOT NULL,
	SHO int NOT NULL,
	WP int NOT NULL,
	BK int NOT NULL,
	CONSTRAINT pk_pps PRIMARY KEY(playerID, team, seasonOrder),
	CONSTRAINT fk_pps_player FOREIGN KEY (playerID) REFERENCES PlayerInfo(playerID),
	CONSTRAINT fk_pps_team FOREIGN KEY (team) REFERENCES Teams(abbreviation)
);

---------- FUNCTIONS ----------

CREATE OR REPLACE FUNCTION calculate_ERA(ER IN int, OUTS IN int)
  RETURN NUMBER IS
BEGIN
  RETURN ER * 27 / OUTS;
END calculate_ERA;
/

CREATE OR REPLACE FUNCTION calculate_WHIP(H IN int, BB IN int, OUTS IN int)
  RETURN NUMBER IS
BEGIN
  RETURN (H + BB) / (OUTS / 3);
END calculate_WHIP;
/

CREATE OR REPLACE FUNCTION calculate_K_perc(K IN int, PA IN int)
  RETURN NUMBER IS
BEGIN
  RETURN (K / PA) * 100;
END calculate_K_perc;
/

CREATE OR REPLACE FUNCTION calculate_BB_perc(BB IN int, PA IN int)
  RETURN NUMBER IS
BEGIN
  RETURN (BB / PA) * 100;
END calculate_BB_perc;  
/

CREATE OR REPLACE FUNCTION calculate_BABIP(H IN NUMBER, HR IN int, AB IN int, K IN int, SF IN int) -- (H-HR)/(AB-SO-HR-SF)
  RETURN NUMBER IS
BEGIN
  RETURN (H - HR) / (AB + SF - K - HR);
END calculate_BABIP;
/

CREATE OR REPLACE FUNCTION GetPA(AB IN int, BB IN int, HBP IN int, SF IN int, SH IN int)
RETURN int IS
BEGIN
RETURN AB + BB + HBP + SF + SH;
END GetPA;
/

CREATE OR REPLACE FUNCTION GetHits(singles IN int, doubles IN int, triples IN int, HR IN int)
RETURN int IS
BEGIN
RETURN singles + doubles + triples + HR;
END GetHits;
/

CREATE OR REPLACE FUNCTION GetBattingAverage(H IN NUMBER, AB IN int)
RETURN NUMBER IS
BEGIN
RETURN H/AB;
END GetBattingAverage;
/

CREATE OR REPLACE FUNCTION GetOBP(H IN int, BB IN int, HBP IN int, PA IN int, SH IN int) --Implement
RETURN NUMBER IS
BEGIN
RETURN (H + BB + HBP) / (PA - SH);
END GetOBP;
/

CREATE OR REPLACE FUNCTION GetSLG(singles IN int, doubles IN int, triples IN int, homeruns IN int, AB IN int)
RETURN NUMBER IS 
BEGIN
RETURN (singles + (2 * doubles) + (3 * triples) + (4 * homeruns))/AB;
END GetSLG;
/

CREATE OR REPLACE FUNCTION GetOPS(OBP IN NUMBER, SLG IN NUMBER)
RETURN NUMBER IS 
BEGIN
RETURN OBP + SLG;
END GetOPS;
/

---------- DATA INSERTION ----------

INSERT INTO Teams VALUES('ASS', 'Asstown', 'Buttes', 'AL', 'Central');
INSERT INTO PlayerInfo VALUES(1, 'Test', 'Player', '01-JAN-2000', 72, 200);
INSERT INTO PlayerBattingSeason VALUES(1, 'ASS', 15, 1, '3', 139, NULL, 559, 117, 27, 8, 30, 129, 83, 67, 4, 139, 6, 7, 0, 7, 49, 5);
INSERT INTO PlayerPitchingSeason VALUES (1,	'ASS', 35, 1, 33, 33, 17, 8, 0,	0, 0, 715, 956,	192, 81, 70, 19, 239, 60, 2, 5,	 6, 1, 2, 1);

---------- BATTING FUNCTION TESTS ----------

SELECT getHits(singles, doubles, triples, HR) AS H, HR, AB, SO, SF, calculate_BABIP(getHits(singles, doubles, triples, HR), HR, AB, SO, SF) AS BABIP FROM PlayerBattingSeason;
SELECT AB, BB, HBP, SF, SH, GetPA(AB, BB, HBP, SF, SH) AS PA FROM PlayerBattingSeason;
SELECT singles, doubles, triples, HR, getHits(singles, doubles, triples, HR) AS H FROM PlayerBattingSeason;
SELECT getHits(singles, doubles, triples, HR) AS H, AB, GetBattingAverage(getHits(singles, doubles, triples, HR), AB) FROM PlayerBattingSeason;
SELECT getHits(singles, doubles, triples, HR) AS H, BB, HBP, GetPA(AB, BB, HBP, SF, SH) AS PA, SH, GetOBP(getHits(singles, doubles, triples, HR), BB, HBP, GetPA(AB, BB, HBP, SF, SH), SH) AS OBP FROM PlayerBattingSeason;
SELECT singles, doubles, triples, HR, AB, GetSLG(singles, doubles, triples, HR, AB) AS SLG FROM PlayerBattingSeason;
SELECT GetOBP(getHits(singles, doubles, triples, HR), BB, HBP, GetPA(AB, BB, HBP, SF, SH), SH) AS OBP, 
GetSLG(singles, doubles, triples, HR, AB) AS SLG, GetOPS(GetOBP(getHits(singles, doubles, triples, HR), BB, HBP, GetPA(AB, BB, HBP, SF, SH), SH), 
GetSLG(singles, doubles, triples, HR, AB)) AS OPS FROM PlayerBattingSeason;

---------- PITCHING FUNCTION TESTS ----------

SELECT ER, OUTS, calculate_ERA(ER, OUTS) AS ERA FROM PlayerPitchingSeason;
SELECT H, BB, OUTS, calculate_WHIP(H, BB, OUTS) FROM PlayerPitchingSeason;
SELECT K, TBF, calculate_K_perc(K, TBF) FROM PlayerPitchingSeason;
SELECT BB, TBF, calculate_BB_perc(BB, TBF) FROM PlayerPitchingSeason;
SELECT H, HR, TBF - BB, K, calculate_BABIP(H, HR, TBF - BB, K, 0) FROM PlayerPitchingSeason;









