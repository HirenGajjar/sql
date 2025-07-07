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

**_It is a sum of a set of values upto a given point in time and includes all the privous values in SUM._**

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

Q. Find the average of virat kohli after match number 50,100,150,200.

```sql
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
ROUND(AVG(SUM(batsman_run))
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2)
AS 'average_till_that_match'
FROM ipl
WHERE batter ='V Kohli'
GROUP BY ID)t
WHERE t.match_number
IN (50,100,150,200);
```

## Running / Moving AVERAGE

It helps getting current trands and patterns in data.

For running average we have to decide the window period let say 5. That is mean we want to find the average of 5 matches window or sum of runs by batter in 5 matches period at perticular given point. In other words, let say we decided to get the average of virat kohli for 5 (window period) matches starting from match number 20. So we will get the data of match number 20,19,18,17,16.

Q. Find the V Kohli's average for 10 matches patch.

```sql
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
```

## Percent of Total

Q. Find the % change of views for yt_views data.

- Group the date for month and year
- Create LAG for previous month column
- Get the diffrence between last moth views and current month
- Find %

```sql
SELECT *
FROM yt_views;
```

```sql
SELECT
YEAR(view_date) AS 'y',
MONTH(view_date) AS 'm',
SUM(views) AS 'current_month_views'
FROM yt_views;
GROUP BY YAER(view_date) , MONTH(view_date);
```

The second code will give us the year | month | current_month_views table - and now we will use LAG() to get the last month view in new column.

```sql
SELECT
YEAR(view_date) AS 'y',
MONTH(view_date) AS 'm',
SUM(views) AS 'current_month_views',
LAG(SUM(views))
OVER(ORDER BY YEAR(view_date) , MONTH(view_date) ) AS 'last_month_views'
FROM yt_views
GROUP BY YEAR(view_date) , MONTH(view_date);
```

Now we will use the above query as a subquery and from that we will create a % change. Although here we can do right in this table , creating new column but as per chatgpt the more generic and standard practice would be creating subquery.

```sql
SELECT y,m,
current_month_views,
last_month_views
FROM(
SELECT
YEAR(view_date) AS 'y',
MONTH(view_date) AS 'm',
SUM(views) AS 'current_month_views',
LAG(SUM(views))
OVER(ORDER BY YEAR(view_date) , MONTH(view_date) )
AS 'last_month_views'
FROM yt_views
GROUP BY YEAR(view_date) , MONTH(view_date)
) AS sub_data
ORDER BY y,m;
```

Now to find the % change we will do ()current_month_views - last_month_views ) divided by last_month_views whole \* 100

```sql
SELECT y,m,current_month_views ,
last_month_views ,
((current_month_views - last_month_views ) / (last_month_views)) * 100
AS '%'
FROM (
SELECT YEAR(view_date) AS 'y',
MONTH(view_date) AS 'm',
SUM(views) AS 'current_month_views',
LAG(SUM(views))
OVER(ORDER BY YEAR(view_date) , MONTH(view_date))
AS 'last_month_views'
FROM yt_views
GROUP BY YEAR(view_date) , MONTH(view_date)
)
AS sub_data
ORDER BY y,m;
```

And that is it.

Additionally we can do Quarter over Quarter views as well.

```sql
SELECT 
y,q,cmv,
LAG(cmv)
OVER(ORDER BY y,q)
AS 'lmv',
(cmv - (
LAG(cmv)
OVER(ORDER BY y,q)
)) / (LAG(cmv) OVER(ORDER BY y,q)) * 100
AS '%'
FROM
(SELECT 
YEAR(view_date) AS 'y',
QUARTER(view_date) AS 'q',
SUM(views) AS 'cmv'
FROM yt_views
GROUP BY YEAR(view_date) , QUARTER(view_date)) AS quarter_data
ORDER BY  y,q;
```

Q.2 Now find the week over week % change.

```sql
SELECT y,w,cwv,
LAG(cwv)
OVER(ORDER BY y,w)
AS 'lwv',
((cwv - LAG(cwv) OVER(ORDER BY y,w)) / (LAG(cwv) OVER( ORDER BY y,w)) ) * 100
AS '%'
FROM(
SELECT 
YEAR(view_date) AS 'y',
WEEK(view_date) AS 'w',
SUM(views) AS 'cwv'
FROM yt_views
GROUP BY YEAR(view_date) , WEEK(view_date)) AS weekly_data
ORDER BY y,w;
```

## Percentile & Quantile

Quantiles means breaking the whole data into equal size intervals.
10 Equal parts of data are called DECILES
4 equal parts of data are called QUARTILES
100 equal parts of data are called PERCENTILES

Each quantile represents the value below which a certain percentage of the data falls.
EX - Quarter 1 or FIRST QUARTILE is 25th PERCENTILE - which means values below 25% of the data falls.
50th Percentile - MEDIAN represents the value below which 50% of the data falls.
