---------- TABLE CREATION ----------

CREATE TABLE teams (
	id int PRIMARY KEY,
	abbreviation varchar(3) PRIMARY KEY,
	city varchar(12) NOT NULL, -- longest value in this column is 'San Francisco'
	team_name varchar(13) NOT NULL, -- longest value in this column is 'Diamondbacks'
	league varchar(2) NOT NULL, -- either 'AL' or 'NL'
	division varchar(7) NOT NULL, -- either 'East', 'Central', or 'West'
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL
);

CREATE TABLE players (
	id int PRIMARY KEY,
	first_name varchar(15) NOT NULL,
	last_name varchar(15) NOT NULL,
	date_of_birth date NOT NULL,
	height int NOT NULL,
	weight int NOT NULL,
    created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL
);

CREATE TABLE batting_seasons
(
  id int NOT NULL,
  season_order int,
  position varchar(10) NOT NULL,
  ab int,
  gp int,
  pa int,
  singles int,
  doubles int,
  triples int,
  hr int,
  tb int,
  r int,
  rbi int,
  bb int,
  ibb int,
  so int,
  hbp int,
  sf int,
  sh int,
  gidp int,
  sb int,
  cs int,
  ba double precision,
  obp double precision,
  slg double precision,
  ops double precision,
  k_percent double precision,
  bb_percent double precision,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  player_id int,
  CONSTRAINT batting_seasons_pkey PRIMARY KEY (id)
);

CREATE TABLE pitching_seasons
(
  id int NOT NULL,
  season_order int,
  gp int,
  gs int,
  w int,
  l int,
  sv int,
  bs int,
  hld int,
  outs int,
  tbf int,
  h int,
  r int,
  er int,
  hr int,
  k int,
  bb int,
  ibb int,
  hbp int,
  cg int,
  sho int,
  wp int,
  bk int,
  era double precision,
  whip double precision,
  k_percent double precision,
  bb_percent double precision,
  babip double precision,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  player_id int,
  CONSTRAINT pk_pps PRIMARY KEY(id),
  CONSTRAINT fk_pps_player FOREIGN KEY (player_id) REFERENCES players(player_id),
  CONSTRAINT fk_pps_team FOREIGN KEY (team_id) REFERENCES teams(id)
);

---------- FUNCTIONS ----------

CREATE OR REPLACE FUNCTION calculate_ERA(er IN int, outs IN int)
  RETURN NUMBER IS
BEGIN
  RETURN er * 27 / outs;
END calculate_ERA;
/

CREATE OR REPLACE FUNCTION calculate_WHIP(h IN int, bb IN int, outs IN int)
  RETURN NUMBER IS
BEGIN
  RETURN (h + bb) / (OUTS / 3);
END calculate_WHIP;
/

CREATE OR REPLACE FUNCTION calculate_K_perc(k IN int, pa IN int)
  RETURN NUMBER IS
BEGIN
  RETURN (k / pa) * 100;
END calculate_K_perc;
/

CREATE OR REPLACE FUNCTION calculate_BB_perc(bb IN int, pa IN int)
  RETURN NUMBER IS
BEGIN
  RETURN (bb / pa) * 100;
END calculate_BB_perc;  
/

CREATE OR REPLACE FUNCTION calculate_BABIP(h IN NUMBER, hr IN int, ab IN int, k IN int, sf IN int) -- (h-hr)/(ab-SO-hr-sf)
  RETURN NUMBER IS
BEGIN
  RETURN (h - hr) / (ab + sf - k - hr);
END calculate_BABIP;
/

CREATE OR REPLACE FUNCTION GetPA(ab IN int, bb IN int, hbp IN int, sf IN int, sh IN int)
RETURN int IS
BEGIN
RETURN ab + bb + hbp + sf + sh;
END GetPA;
/

CREATE OR REPLACE FUNCTION GetHits(singles IN int, doubles IN int, triples IN int, hr IN int)
RETURN int IS
BEGIN
RETURN singles + doubles + triples + hr;
END GetHits;
/

CREATE OR REPLACE FUNCTION GetBattingAverage(h IN NUMBER, ab IN int)
RETURN NUMBER IS
BEGIN
RETURN h/ab;
END GetBattingAverage;
/

CREATE OR REPLACE FUNCTION GetOBP(h IN int, bb IN int, hbp IN int, pa IN int, sh IN int) --Implement
RETURN NUMBER IS
BEGIN
RETURN (h + bb + hbp) / (pa - sh);
END GetOBP;
/

CREATE OR REPLACE FUNCTION GetSLG(singles IN int, doubles IN int, triples IN int, homeruns IN int, ab IN int)
RETURN NUMBER IS 
BEGIN
RETURN (singles + (2 * doubles) + (3 * triples) + (4 * homeruns))/ab;
END GetSLG;
/

CREATE OR REPLACE FUNCTION GetOPS(obp IN NUMBER, slg IN NUMBER)
RETURN NUMBER IS 
BEGIN
RETURN obp + slg;
END GetOPS;
/

---------- DATA INSERTION ----------

INSERT INTO Teams VALUES('ASS', 'Asstown', 'Buttes', 'AL', 'Central');
INSERT INTO PlayerInfo VALUES(1, 'Test', 'Player', '01-JAN-2000', 72, 200);
INSERT INTO PlayerBattingSeason VALUES(1, 'ASS', 15, 1, '3', 139, NULL, 559, 117, 27, 8, 30, 129, 83, 67, 4, 139, 6, 7, 0, 7, 49, 5);
INSERT INTO PlayerPitchingSeason VALUES (1,	'ASS', 35, 1, 33, 33, 17, 8, 0,	0, 0, 715, 956,	192, 81, 70, 19, 239, 60, 2, 5,	 6, 1, 2, 1);

---------- BATTING FUNCTION TESTS ----------

SELECT getHits(singles, doubles, triples, hr) AS h, hr, ab, SO, sf, calculate_BABIP(getHits(singles, doubles, triples, hr), hr, ab, SO, sf) AS BABIP FROM PlayerBattingSeason;
SELECT ab, bb, hbp, sf, sh, GetPA(ab, bb, hbp, sf, sh) AS pa FROM PlayerBattingSeason;
SELECT singles, doubles, triples, hr, getHits(singles, doubles, triples, hr) AS h FROM PlayerBattingSeason;
SELECT getHits(singles, doubles, triples, hr) AS h, ab, GetBattingAverage(getHits(singles, doubles, triples, hr), ab) FROM PlayerBattingSeason;
SELECT getHits(singles, doubles, triples, hr) AS h, bb, hbp, GetPA(ab, bb, hbp, sf, sh) AS pa, sh, GetOBP(getHits(singles, doubles, triples, hr), bb, hbp, GetPA(ab, bb, hbp, sf, sh), sh) AS obp FROM PlayerBattingSeason;
SELECT singles, doubles, triples, hr, ab, GetSLG(singles, doubles, triples, hr, ab) AS slg FROM PlayerBattingSeason;
SELECT GetOBP(getHits(singles, doubles, triples, hr), bb, hbp, GetPA(ab, bb, hbp, sf, sh), sh) AS obp, 
GetSLG(singles, doubles, triples, hr, ab) AS slg, GetOPS(GetOBP(getHits(singles, doubles, triples, hr), bb, hbp, GetPA(ab, bb, hbp, sf, sh), sh), 
GetSLG(singles, doubles, triples, hr, ab)) AS OPS FROM PlayerBattingSeason;

---------- PITCHING FUNCTION TESTS ----------

SELECT er, OUTS, calculate_ERA(er, OUTS) AS ERA FROM PlayerPitchingSeason;
SELECT h, bb, OUTS, calculate_WHIP(h, bb, OUTS) FROM PlayerPitchingSeason;
SELECT k, TBF, calculate_K_perc(k, TBF) FROM PlayerPitchingSeason;
SELECT bb, TBF, calculate_BB_perc(bb, TBF) FROM PlayerPitchingSeason;
SELECT h, hr, TBF - bb, k, calculate_BABIP(h, hr, TBF - bb, k, 0) FROM PlayerPitchingSeason;









