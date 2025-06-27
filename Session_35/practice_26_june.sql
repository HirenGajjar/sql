CREATE DATABASE IF NOT EXISTS s_35_practice;

USE s_35_practice;

SELECT *
FROM movies;

-- Find the movie in each year that was highest scored for that year

SELECT year,MAX(score) AS 'highest_rated'
FROM movies
GROUP BY year
ORDER BY year;

-- Find the movie in whole dataset that has hightest rating

SELECT *
FROM movies
WHERE score = (
SELECT MAX(score) 
FROM movies);

-- Find the movie that is highest profitable movie

SELECT *
FROM movies
WHERE (gross - budget) = 
(SELECT MAX(gross-budget)
FROM movies);

-- We can achieve same result using ORDER BY 
 
SELECT * 
FROM movies
ORDER BY (gross- budget) 
DESC LIMIT 1;

-- Find the movies that has above average score

SELECT COUNT(*)
FROM movies
WHERE score > (
SELECT 
AVG(score)
FROM movies
);

-- Find the movie that has the highest score in year 2000


SELECT *
FROM movies
WHERE  year = 2000 
AND 
score = (SELECT MAX(score)
FROM movies
WHERE year =2000);

-- Find the movies that has the highest score where the number of votes > the average database votes
-- Find the AVG(votes) first
-- Find the movies that has the votes higher then the average
-- Order by by score 
SELECT *
FROM movies
WHERE votes > (
SELECT AVG(votes)
FROM movies)
ORDER BY score DESC LIMIT 1;



