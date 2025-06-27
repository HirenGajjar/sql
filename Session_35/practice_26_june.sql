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

-- Same thing using different approach
SELECT *
FROM movies
WHERE score = (
SELECT MAX(score)
FROM movies
WHERE votes > (
SELECT 
AVG(votes)
FROM movies
));

SELECT *
FROM orders;

SELECT *
FROM users;

SELECT * 
FROM order_details;

SELECT *
FROM delivery_partner;

-- Find all the users who never order 

SELECT *
FROM users u1
LEFT JOIN orders o1
ON u1.user_id = o1.user_id
WHERE o1.amount IS NULL;

-- Using subquery

SELECT DISTINCT(user_id)
FROM orders;

SELECT *
FROM users
WHERE user_id 
NOT IN (
SELECT 
DISTINCT(user_id)
FROM orders
);

-- Find top 3 directors and thier movies based on the highest gross movies
-- Group by directors -> Find SUM of their all movies -> Order them by that sum -> LIMIT top 3
-- Now use those 3 directors to find all thier movies 

SELECT director 
FROM movies
GROUP BY director
ORDER BY SUM(gross) DESC LIMIT 3;

SELECT *
FROM movies
WHERE director IN (
SELECT director
FROM movies
GROUP BY director
ORDER BY SUM(gross)
DESC LIMIT 3
);

-- Find movies of the actors who has the average score > 8.5 in their movies with minimum of votes of 25000 or more
-- Filter for votes

SELECT *
FROM movies
WHERE votes > 25000;

-- Group by actors , use above filter , filter for their average score > 8.5

SELECT star
FROM movies
WHERE votes > 25000
GROUP BY star
HAVING AVG(score) > 8.5;

-- Use the name of the actors to find thier movies

SELECT *
FROM movies
WHERE star IN (
SELECT star
FROM movies
WHERE votes > 25000
GROUP BY star
HAVING AVG(score) > 8.5
);

-- Find the most profitable movie each year
-- Group by year
-- Find the movies that earned most in that year MAX(gross - budget) 
-- Use that table to get the name of the movie

SELECT year, MAX(gross- budget)
FROM movies
GROUP BY year;

SELECT *
FROM movies
WHERE (year ,(gross - budget)) IN (
SELECT year,
MAX(gross-budget)
FROM movies
GROUP BY year
);

