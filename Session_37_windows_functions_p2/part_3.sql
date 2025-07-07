USE window_functions_session_37_p_3;

SELECT *
FROM yt_views;

SELECT YEAR(view_date) , MONTH(view_date) ,
SUM(views)
FROM yt_views
GROUP BY YEAR(view_date) , MONTH(view_date)
ORDER BY YEAR(view_date), MONTH(view_date);

-- Find the % change of views per month

SELECT YEAR(view_date) , MONTH(view_date) ,
SUM(views) AS 'current_month_views',
LAG(SUM(views))
OVER(ORDER BY YEAR(view_date) , MONTH(view_date)) 
AS 'last_month_views',
((SUM(views) - LAG(SUM(views))
OVER(ORDER BY YEAR(view_date) , MONTH(view_date)) ) / (LAG(SUM(views))
OVER(ORDER BY YEAR(view_date) , MONTH(view_date)) )) * 100
AS '%'
FROM yt_views
GROUP BY YEAR(view_date) , MONTH(view_date)
ORDER BY YEAR(view_date), MONTH(view_date);

SELECT y , m, 
current_month_views ,
last_month_views ,
((current_month_views - last_month_views) / (last_month_views) ) * 100 
AS '%'
FROM
(SELECT YEAR(view_date) AS 'y', 
MONTH(view_date) AS 'm',
SUM(views) AS 'current_month_views',
LAG(SUM(views))
OVER(ORDER BY YEAR(view_date) , MONTH(view_date)) 
AS 'last_month_views'
FROM yt_views
GROUP BY YEAR(view_date) , MONTH(view_date) ) AS data
ORDER BY y , m;


SELECT 
YEAR(view_date) AS 'y',
QUARTER() AS 'q'
FROM yt_views
GROUP BY YEAR(view_date) ,QUARTER(view_date)



