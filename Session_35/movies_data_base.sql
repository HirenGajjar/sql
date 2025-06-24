CREATE DATABASE IF NOT EXISTS session_35;

USE session_35;

SELECT * 
FROM movies;
-- Highest rated/scored movies
SELECT *
FROM movies
ORDER BY score DESC LIMIT 1;

-- We want to make a same output using subquery
-- We can use the query above 

SELECT *
FROM movies
WHERE score = (SELECT MAX(score) 
FROM movies);


-- Independent Subquery - scalar subquery

SELECT *
FROM movies
ORDER BY (gross - budget) DESC LIMIT 1;
-- Find the movie with highest Profit (not using Order by)

SELECT * 
FROM movies
WHERE (gross - budget) = (SELECT MAX(gross-budget) FROM movies);

-- Find the number of movies that has above average rating/score

SELECT AVG(score) 
FROM movies;

SELECT COUNT(*)
FROM movies
WHERE score > 
(SELECT AVG(score) 
FROM movies)
;

-- Find the hightst rated/scored movie of year 2000

SELECT MAX(score)
FROM movies
WHERE year = 2000;

SELECT *
FROM movies
WHERE year = 2000
AND score = (SELECT MAX(score)
FROM movies
WHERE year = 2000);


-- Find the highest rated movies from all the movies where the number of votes are > the avg votes

SELECT AVG(votes)
FROM movies;

SELECT *
FROM movies 
WHERE votes > (SELECT AVG(votes)
FROM movies)
ORDER BY score DESC LIMIT 1
;

-- Same problem can be solve using nested sub query

SELECT * 
FROM movies
WHERE score = (
SELECT MAX(score)
FROM movies
WHERE votes >  (
SELECT AVG(votes)
FROM movies
)
)