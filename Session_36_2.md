## RANKING

We are using ipl data. And want to find the following answers.

Q.1. FInd the top 5 batsman from each team.

Here we weill use many things together. First we have to do a GROUP BY with team and batter, that will give us to COUNT() runs by each team.

Doing that will give us Team | Batsman | Run by batsman. Now that we have total run by each batter in each team we will use DENSE_RANK() and will PARTITION BY() team and ORDER BY SUM of runs by each batter.

```sql
SELECT * 
FROM ipl;
```


```sql
SELECT BattingTeam , batter
FROM ipl
GROUP BY BattingTeam, batter;
```

Here we got the group of batter for each team, now we will get the sum of runs by batter for each team.

```sql
SELECT BattingTeam, batter,
SUM(batsman_run) AS 'total_runs'
FROM ipl
GROUP BY BattingTeam, batter;
```

Here we have each team | Batter from team | Total runs by each batter. Now we will use DENSE_RANK() that to with PARTITION BY BattingTeam and ORDER total_runs or SUM(batsman_run) - because that will give us the ranking within each team by runs in DESC order.

```sql
SELECT BattingTeamm,batter,
SUM(batsman_run) AS 'total_runs',
DENSE_RANK()
OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC)
AS 'rank_within_team'
FROM ipl
GROUP BY BattingTeam, batter;
```

The last step is to use the following query as a subquery where we will select players from each team where rank is 1 to 5.

```sql
SELECT *
FROM (
SELECT BattingTeam, batter,
SUM(batsman_run) 
AS 'total_runs',
DENSE_RANK()
OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run ) DESC)
AS 'rank_within_team'
FROM ipl
GROUP BY BattingTeam , batter;
) t
WHERE t.rank_within_team < 6
ORDER BY BattingTeam , rank_within_team;
```

And that is it. It will give us the Top 5 performers from each team and thier total runs. Note that Rising Pune has two different names that is why it is giving two different tables. One with 's' in the end and one without.

## Cumulative SUM

***It is a sum of a set of values upto a given point in time and includes all the privous values in SUM.***

Q.2. Find the total runs by Virat Kohli at 50 matches, 100 matches, 150 matches , 200 matches etc.

Here is what we will do to solve the question.

First we will get the data where batsman is 'V Kohli'.

```sql
SELECT *
FROM ipl
WHERE batter = 'V Kohli';
```

Now we have a ID column that is basically match number - that has ball by ball data. So we will do the GROUP BY ID and that will allow use to get the runs of virat kohli in that match.

```sql
SELECT ID ,
SUM(batsman_run) AS 'runs'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;
```

Here we have ID (match) and runs in that match by V Kohli. Now we will use ROW_NUMBER() that will simply give use the unique increment row number to each match.

```sql
SELECT ID,
SUM(batsman_run) AS 'runs',
ROW_NUMBER()
OVER() AS 'match_number'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;
```

Now that we have match number , runs per match - all we need is to find out the cumulative sum for each row. To do that we will use aggregation over batsman_run with OVER() with ORDER BY ID so that it will create a frame that will start with first row and will have current row that will increase as row by row. We will create a new column that will add the sun of score from each row and will shift the frame to next row using ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW. Here We are using ROW BETWEEN - that means we want to go row by row. We will start from first row - UNBOUNDED PRECEDING and the frame is till current row AND CURRENT ROW. As the sum takes place the current window will expand.

```sql
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
```

Here we have the new column that is cumulative sum for each match after match - called 'runs_till_that_match'.

Now the last step is to use the above query as a subquery and get the data for match numbers we need.

```sql
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
WHERE t.match_number 
IN (50,100,150,200);
```

And that is it. Now we have a table that gives us the run till match 50,100,150, and 200.

## Cumulative AVERAGE
