USE ipl;

SELECT * 
FROM ipl.ipl;

-- Top 5 batsman with most runs

SELECT batter ,
SUM(batsman_run) AS "total_run"
FROM ipl.ipl
GROUP BY batter
ORDER BY total_run DESC LIMIT 5;

-- Find the second Hightest 6 hiiter in IPL

SELECT batter , 
COUNT(*) AS "number_of_sixes"
FROM ipl.ipl
WHERE batsman_run = 6
GROUP BY batter
ORDER BY number_of_sixes DESC LIMIT 1,1;

-- Find all the innings in which batsman scored century

SELECT batter , ID,
SUM(batsman_run) AS "score"
FROM ipl.ipl
GROUP BY batter , ID 
HAVING score >= 100
ORDER BY score DESC;

-- Top 5 batsman with highest strike rate , minimum of 1000 Balls faced

SELECT batter, 
SUM(batsman_run) AS "runs",
COUNT(batsman_run) AS "balls",
ROUND((SUM(batsman_run)/COUNT(batsman_run) )*100,2) AS "strike_rate"
FROM ipl.ipl
GROUP BY batter
HAVING balls > 1000
ORDER BY strike_rate DESC LIMIT 10;

