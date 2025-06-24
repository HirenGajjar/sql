USE session_35;

SELECT *
FROM orders;

SELECT *
FROM users;

-- Find all the users who never order 
-- Answer is user_id 6,7

SELECT DISTINCT(user_id)
FROM orders;

SELECT *
FROM users
WHERE user_id NOT IN (

SELECT DISTINCT(user_id)
FROM orders
);

-- Find all the movies of Top 3 director based on total eranings of their movies

SELECT *
FROM movies;

-- Here are the top 3 directors with hightest earning from their movies
SELECT DISTINCT(director)
FROM movies
GROUP BY director
ORDER BY SUM(gross) DESC LIMIT 3;

-- We need not names only but all of their movies

SELECT *
FROM movies
WHERE direcotr IN (
SELECT director
FROM movies
GROUP BY director
ORDER BY SUM(gross) DESC LIMIT 3
);


-- Our solution is correct althought it is not supported in MYSQL

-- Find movies of all the actors whose Filmography's average rating/score is > 8.5 at minimum of 25000 Votes

-- Lets get all the movies where votes > 25000

SELECT *
FROM movies
WHERE votes > 25000;




-- Now we will group by based on star and see their average score

SELECT star , 
AVG(score)
FROM movies
WHERE votes > 25000
GROUP BY star;

-- Now that we have actors with average score and minimum of 25000 votes - we will filter those having score over 8.5

SELECT star, AVG(score)
FROM movies
WHERE votes > 25000
GROUP BY star
HAVING AVG(score) > 8.5;

-- Now we have actors with > 8.5 average score that is based on the movies that have minimum of 25000 votes

SELECT *
FROM movies
WHERE star IN (
SELECT star
FROM movies
WHERE votes > 25000
GROUP BY star
HAVING AVG(score) > 8.5);


