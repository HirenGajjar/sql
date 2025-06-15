USE session_32;

SELECT * 
FROM session_32.data;

SELECT *
FROM session_32.data
WHERE region = "southwest" 
AND gender = "male";

SELECT * 
FROM session_32.data
WHERE bmi 
BETWEEN 30 AND 45;

SELECT 
MIN(bloodpressure) AS "MinBP",
MAX(bloodpressure) AS "MaxBP"
FROM session_32.data
WHERE smoker = "Yes" 
AND diabetic = "Yes";

SELECT 
COUNT(DISTINCT(PatientID))
FROM session_32.data
WHERE region NOT IN ("southwest");

SELECT 
SUM(claim)
FROM session_32.data
WHERE gender = "male" 
AND smoker = "Yes";

SELECT * 
FROM session_32.data
WHERE region 
IN ("southeast", "southwest");

SELECT 
COUNT(*)
FROM session_32.data
WHERE bloodpressure 
BETWEEN 90 AND 120;

SELECT 
COUNT(*)
FROM session_32.data
WHERE age < 17 
AND bloodpressure 
BETWEEN (80 + (age*2) ) AND ( 100 + (age*2));

SELECT
AVG(claim)
FROM session_32.data
WHERE gender = "female"
AND smoker ="No"
AND diabetic = "Yes";

UPDATE session_32.data
SET claim = 5000
WHERE PatientID = 1234;

SELECT * 
FROM session_32.data
WHERE PatientID = 1234;



DELETE 
FROM session_32.data
WHERE smoker = "Yes"
AND children =0;

SELECT *
FROM session_32.data
WHERE smoker = "Yes"
AND children = 0;
