SELECT *
FROM movies;

-- Find out the most profitable movies from each year

-- Lets get the each year and highest grossing movie

SELECT year,MAX(gross - budget)
FROM movies
GROUP BY year;
-- This query gets us the movie from each year that earned the most

-- Now lets get the name for each movie based on the result from the above

SELECT *
FROM movies
WHERE (year, (gross-budget) ) IN (
SELECT year ,
MAX(gross- budget) 
AS "Profit"
FROM movies
GROUP BY year);


-- Q.2. Find the highest movie from each gonergenre that has max score , where minimum of votes are 25000 or more

-- Lets get the MAX score for each genre where votes are > 25000
SELECT genre,
MAX(score)
FROM movies
WHERE votes > 25000
GROUP BY genre;

