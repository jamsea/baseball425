CREATE TABLE teams (
	abbreviation varchar(3) PRIMARY KEY,
	city varchar(13) NOT NULL, -- longest value in this column is 'San Francisco'
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

CREATE TABLE batting_seasons (
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

CREATE OR REPLACE FUNCTION calculate_ERA(er IN NUMBER, outs IN NUMBER)
  RETURN NUMBER IS
BEGIN
  RETURN er * 27 / outs;
END calculate_ERA;
/

CREATE OR REPLACE FUNCTION calculate_WHIP(h IN NUMBER, bb IN NUMBER, outs IN NUMBER)
  RETURN NUMBER IS
BEGIN
  RETURN (h + bb) / (outs / 3);
END calculate_WHIP;
/

CREATE OR REPLACE FUNCTION calculate_K_perc(k IN NUMBER, pa IN NUMBER)
  RETURN NUMBER IS
BEGIN
  RETURN (k / pa) * 100;
END calculate_K_perc;
/

CREATE OR REPLACE FUNCTION calculate_BB_perc(bb IN NUMBER, pa IN NUMBER)
  RETURN NUMBER IS
BEGIN
  RETURN (bb / pa) * 100;
END calculate_BB_perc;  
/

CREATE OR REPLACE FUNCTION calculate_BABIP(h IN NUMBER, hr IN int, ab IN int, k IN int, sf IN int) -- (h-hr)/(ab-so-hr-sf)
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

--Need to be tested
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

CREATE OR REPLACE FUNCTION GetOPS(OBP IN NUMBER, SLG IN NUMBER)
RETURN NUMBER IS 
BEGIN
RETURN OBP + SLG;
END GetOPS;
/

SELECT getHits(singles, doubles, triples, hr) AS h, hr, ab, so, sf, calculate_BABIP(getHits(singles, doubles, triples, hr), hr, ab, so, sf) AS BABIP FROM PlayerBattingSeason;
SELECT ab, bb, hbp, sf, sh, GetPA(ab, bb, hbp, sf, sh) AS pa FROM PlayerBattingSeason;
SELECT singles, doubles, triples, hr, getHits(singles, doubles, triples, hr) AS h FROM PlayerBattingSeason;
SELECT getHits(singles, doubles, triples, hr) AS h, ab, GetBattingAverage(getHits(singles, doubles, triples, hr), ab) FROM PlayerBattingSeason;
SELECT getHits(singles, doubles, triples, hr) AS h, bb, hbp, GetPA(ab, bb, hbp, sf, sh) AS pa, sh, GetOBP(getHits(singles, doubles, triples, hr), bb, hbp, GetPA(ab, bb, hbp, sf, sh), sh) AS OBP FROM PlayerBattingSeason;
SELECT singles, doubles, triples, hr, ab, GetSLG(singles, doubles, triples, hr, ab) AS SLG FROM PlayerBattingSeason;
SELECT GetOBP(getHits(singles, doubles, triples, hr), bb, hbp, GetPA(ab, bb, hbp, sf, sh), sh) AS OBP, 
GetSLG(singles, doubles, triples, hr, ab) AS SLG, GetOPS(GetOBP(getHits(singles, doubles, triples, hr), bb, hbp, GetPA(ab, bb, hbp, sf, sh), sh), 
GetSLG(singles, doubles, triples, hr, ab)) AS OPS FROM PlayerBattingSeason;

CREATE OR REPLACE TRIGGER PATrigger
  BEFORE
    INSERT OR UPDATE 
  ON PlayerBattingSeason
  FOR EACH ROW
BEGIN
  CASE
    WHEN INSERTING OR UPDATING THEN
		:NEW.pa := GetPA(:NEW.ab, :NEW.bb, :NEW.hbp, :NEW.sf, :NEW.sh);
  END CASE;
END;
/

CREATE OR REPLACE TRIGGER IPTrigger
  BEFORE
    INSERT OR UPDATE 
  ON pitching_seasons
  FOR EACH ROW
BEGIN
  CASE
    WHEN INSERTING OR UPDATING THEN
		:NEW.outs := FLOOR(:NEW.ip) * 3 + (10 * :NEW.ip - FLOOR(:NEW.ip));
  END CASE;
END;
/

UPDATE PlayerBattingSeason
 SET pa = GetPA(ab, bb, hbp, sf, sh);
 
UPDATE pitching_seasons
 SET outs = FLOOR(ip) * 3 + (10 * ip - FLOOR(ip));
 
 CREATE OR REPLACE VIEW v_Batters AS
	SELECT MAX(first_name) || ' ' || MAX(last_name) AS Name, SUM(gp) AS gp, SUM(pa) AS pa, SUM(ab) AS ab, 
	TO_CHAR(ROUND(GetBattingAverage(getHits(SUM(singles), SUM(doubles), SUM(triples), SUM(hr)), SUM(ab)),3), '9.999') AS AVG,
	TO_CHAR(ROUND(GetOBP(getHits(SUM(singles), SUM(doubles), SUM(triples), SUM(hr)), SUM(bb), SUM(hbp), GetPA(SUM(ab), SUM(bb), SUM(hbp), SUM(sf), SUM(sh)), SUM(sh)),3), '9.999') AS OBP,
	TO_CHAR(ROUND(GetSLG(SUM(singles), SUM(doubles), SUM(triples), SUM(hr), SUM(ab)),3), '9.999') AS SLG,
	TO_CHAR(ROUND(GetOPS(GetOBP(getHits(SUM(singles), SUM(doubles), SUM(triples), SUM(hr)), SUM(bb), SUM(hbp), 
	GetPA(SUM(ab), SUM(bb), SUM(hbp), SUM(sf), SUM(sh)), SUM(sh)), 
	GetSLG(SUM(singles), SUM(doubles), SUM(triples), SUM(hr), SUM(ab))),3), '9.999') AS OPS,
	getHits(SUM(singles), SUM(doubles), SUM(triples), SUM(hr)) AS h, 
	SUM(hr) AS hr , SUM(r) AS r, SUM(rbi) AS rbi, SUM(sb) AS sb, SUM(cs) AS cs, SUM(bb) AS bb, SUM(ibb) AS ibb, 
	SUM(so) AS so, SUM(hbp) AS hbp, SUM(sf) AS sf, SUM(sh) AS sh, SUM(gidp) AS gidp
	FROM PlayerBattingSeason a LEFT JOIN players b ON a.id = b.id
	GROUP BY a.PlayerID
	ORDER BY OPS DESC;

 CREATE OR REPLACE VIEW v_Pitchers AS
	SELECT MAX(first_name) || ' ' || MAX(last_name) AS Name, SUM(gp) AS gp, SUM(gs) AS gs, TO_CHAR(calculate_ERA(SUM(er), SUM(outs)), '0.00') AS ERA,
	TO_CHAR(calculate_WHIP(SUM(h), SUM(bb), SUM(outs)), '0.00') AS WHIP, SUM(w) AS w, SUM(l) AS l, SUM(sv) AS sv,
	FLOOR(SUM(outs)/3) + MOD(SUM(outs),3)/10 AS ip, SUM(tbf) AS tbf, SUM(h) AS h, SUM(r) AS r, SUM(er) AS er, SUM(hr) AS hr, 
	SUM(k) AS k, SUM(bb) AS bb, SUM(ibb) AS ibb, SUM(hbp) AS hbp,SUM(cg) AS cg, SUM(sho) AS sho, SUM(wp) AS wp, SUM(bk) AS bk
	FROM pitching_seasons a LEFT JOIN players b ON a.id = b.id
	GROUP BY a.PlayerID
	ORDER BY ip DESC;	
	
SELECT er, outs, TO_CHAR(calculate_ERA(er, outs), '0.00') AS ERA
From playerpitchingseason
where playerid = 1060;




