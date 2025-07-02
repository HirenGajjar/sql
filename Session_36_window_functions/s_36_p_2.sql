CREATE DATABASE IF NOT EXISTS ipl;
USE ipl;

select * from ipl;
SELECT *
FROM 
(SELECT BattingTeam ,batter, 
SUM(batsman_run) AS 'total_runs',
DENSE_RANK()
OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) 
AS 'rank_within_team'
FROM ipl
GROUP BY BattingTeam , batter) t
WHERE rank_within_team < 6
ORDER BY BattingTeam , rank_within_team ;

SELECT BattingTeam ,batter,
SUM(batsman_run) AS 'total_run'
FROM ipl
GROUP BY BattingTeam, batter;

-- Q.2
SELECT *
FROM ipl
WHERE batter = 'V Kohli';


SELECT ID ,
SUM(batsman_run) AS 'runs'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;

SELECT ID,
SUM(batsman_run) AS 'runs',
ROW_NUMBER()
OVER() AS 'match_number'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;

SELECT ID ,
SUM(batsman_run) AS 'runs',
ROW_NUMBER()
OVER(ORDER BY ID) AS 'match_number',
SUM(SUM(batsman_run))
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'runs_till_that_match'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;


SELECT *
FROM (
SELECT ID,
SUM(batsman_run) AS 'runs',
ROW_NUMBER( )
OVER(ORDER BY ID) AS 'match_number',
SUM(SUM(batsman_run))
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'runs_till_that_match'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
) t
WHERE t.match_number 
IN (50,100,150,200);




SELECT *
FROM (
SELECT ID,
SUM(batsman_run) AS 'runs',
ROW_NUMBER()
OVER(ORDER BY ID) AS 'match_number',
SUM(SUM(batsman_run))
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'runs_till_that_match'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
) t
WHERE t.match_number 
IN (50,100,150,200);

SELECT match_number , runs_till_that_match
FROM (
SELECT ID,
SUM(batsman_run) AS 'runs',
ROW_NUMBER()
OVER(ORDER BY ID) AS 'match_number',
SUM(SUM(batsman_run))
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'runs_till_that_match'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
) t
WHERE match_number 
IN(50,100,150,200);



SELECT match_number ,
average_till_that_match
FROM (
SELECT 
SUM(batsman_run) AS 'that_match_run',
ROW_NUMBER()
OVER(ORDER BY ID) AS 'match_number',
SUM(SUM(batsman_run))
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'runs_till_that_match',
AVG(SUM(batsman_run)) 
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'average_till_that_match'
FROM ipl
WHERE batter ='V Kohli'
GROUP BY ID
)t 
WHERE t.match_number 
IN (50,100,150,200);

SELECT *
FROM ipl
WHERE batter = 'V Kohli';

SELECT 
ROW_NUMBER()
OVER(ORDER BY ID)
AS 'match_number',
SUM(batsman_run) 
AS 'runs_in_that_match',
SUM(SUM(batsman_run))
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
AS 'runs_till_that_match',
AVG(SUM(batsman_run))
OVER(ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) 
AS 'running_average_for_10_matches'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;



