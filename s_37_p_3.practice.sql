USE window_functions_session_37_p_3;

SELECT *
FROM yt_views;

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