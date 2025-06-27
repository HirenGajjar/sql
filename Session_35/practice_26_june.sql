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

-- Find the highest rated movie in each genre where the minimum votes are 25000
-- Group by Genre
-- MAX(score) 
-- Filter votes

SELECT genre , 
MAX(score)
FROM movies
WHERE votes > 25000
GROUP BY genre;

SELECT *
FROM movies
WHERE (genre, score) IN 
(
SELECT genre,
MAX(score)
FROM movies
WHERE votes> 25000
GROUP BY genre
);

-- Find the top 5 highest grossing movie for star-director combo for gross income
-- Group by director -star 
-- MAX(gross)
-- Use names for the more details of movies

SELECT star,director
FROM movies
GROUP BY star,director
ORDER BY MAX(gross) DESC LIMIT 5;

SELECT *
FROM movies
WHERE (star,director) 
IN 
(
SELECT star,director
FROM movies
GROUP BY star, director
ORDER BY MAX(gross)
DESC LIMIT 5
);

-- Find all the movies that has the score > AVG(score) of that genre
-- Average score of genre

SELECT AVG(score),genre
FROM movies
GROUP BY genre;



 SELECT COUNT(*)
 FROM movies m1
 WHERE score >
 (
 SELECT 
 AVG(score)
 FROM movies m2
 WHERE m2.genre = m1.genre
 );
 
 SELECT COUNT(*)
 FROM movies m1
 JOIN (
 SELECT genre,
 AVG(score) AS 'm2_avg_score'
 FROM movies 
 GROUP BY genre) AS m2
 ON m1.genre = m2.genre
 WHERE m1.score > m2.m2_avg_score;
 
-- Find the favorite food for each customer based on the number of orders repeated by customer
-- food table, order_details, orders, users

SELECT *
FROM orders;

SELECT *
FROM users;

SELECT * 
FROM order_details;

SELECT *
FROM delivery_partner;

SELECT *
FROM food;

WITH fav_food AS(
SELECT u.user_id,u.name, f.f_name,
COUNT(*) AS 'food_order_count'
FROM orders o 
JOIN users u 
ON o.user_id = u.user_id
JOIN order_details od 
ON o.order_id = od.order_id
JOIN food f 
ON od.f_id = f.f_id
GROUP BY u.name ,f.f_name,u.user_id
ORDER BY u.name ASC ,
food_order_count DESC )

SELECT *
FROM fav_food f1
WHERE food_order_count =
(SELECT MAX(food_order_count)
FROM fav_food f2
WHERE f2.user_id = f1.user_id
);


-- Get the % of votes for each movie compare to the total number of votes
-- Get the total votes
SELECT *
FROM movies;
SELECT SUM(votes)
FROM movies;

SELECT name, 
(votes / 
(SELECT 
SUM(votes)
FROM movies)) * 100 
AS '%_of_votes'
FROM movies;


-- Q.2. Display the name of all movies, genre, score and average score
-- Find the average score of each genre 
-- Group by genre - find the average

SELECT name,genre, score ,
(SELECT
ROUND(AVG(score),2)
FROM movies m1
WHERE m1.genre = m2.genre) 
AS 'genre_ave_score'
FROM movies m2;
	
SELECT m1.name, m1.genre , 
m1.score,m2.average_genre_score
FROM movies m1
JOIN (
SELECT genre, 
AVG(score)  AS 'average_genre_score'
FROM movies
GROUP BY genre) 
AS m2
ON m1.genre = m2.genre;

-- Find the average ratings for each restaurant

SELECT *
FROM restaurants;

SELECT *
FROM orders;



SELECT r_name, 
ave_ras_rate 
FROM(
SELECT 
r_id, 
AVG(restaurant_rating)
AS 'ave_ras_rate'
FROM orders
GROUP BY r_id) t2
JOIN restaurants r 
ON r.r_id = t2.r_id;

-- Find genres having score > average score of all movies in dataset
-- Ave score of all
SELECT AVG(score)
FROM movies;

SELECT genre,
AVG(score) 
AS 'ave_genre_score'
FROM movies
GROUP BY genre
HAVING ave_genre_score >
(
SELECT AVG(score) 
AS 'ave_score'
FROM movies
);


-- Create a new table 'loyal_customers' for the customers who had ordered at least 3 times or more

SELECT *
FROM users;

SELECT *
FROM orders;

CREATE TABLE IF NOT EXISTS loyal_customers
(user_id INT ,
name VARCHAR(255),
money FLOAT
);


INSERT 
INTO loyal_customers
(user_id,name) 
(
SELECT o.user_id ,u.name
FROM orders o
JOIN users u 
ON o.user_id = u.user_id
GROUP BY o.user_id ,u.name
HAVING COUNT(*) > 3);

SELECT * 
FROM loyal_customers;

-- Q.1. Now provide the 10% app money into the loyal_customers money column basd on their order value.
-- FInd the total order and total spending

SELECT user_id , 
SUM(amount) AS total_spendings,
SUM(amount)/10 AS app_money
FROM orders 
GROUP BY user_id ;

UPDATE loyal_customers
SET money = (
SELECT SUM(amount) / 10 
FROM orders
);

SELECT *
FROM loyal_customers;

-- Delete all the customers who never ordered

SELECT *
FROM orders;

SELECT *
FROM users;



DELETE FROM users 
WHERE user_id IN (
  SELECT user_id FROM (
    SELECT u.user_id
    FROM users u
    LEFT JOIN orders o 
    ON u.user_id = o.user_id
    WHERE o.amount 
    IS NULL
  ) AS sub
);
