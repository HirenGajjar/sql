-- Find the movies for each genre where it has rating higher than the average rating of that perticular genre

-- FInd average score for each genre

SELECT genre, AVG(score)
FROM movies
GROUP BY genre;

-- Now lets get the movies 

SELECT *
FROM movies m1
WHERE score > (SELECT AVG(score)
FROM movies m2
WHERE m1.genre = m2.genre);


-- Find the favorite food for each customer (based on repetation)
-- The data is spread in 4 different tables order ,order_details and users, food
SELECT * 
FROM order_details;

SELECT *
FROM food;

SELECT * 
FROM orders;

SELECT * 
FROM users;

-- Lets Join them first

SELECT name , f_name
FROM users u
JOIN orders o 
ON u.user_id = o.user_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN food f
ON od.f_id = f.f_id;

-- lets group them with name and f_name

SELECT name , f_name, COUNT(*)
FROM users u
JOIN orders o 
ON u.user_id = o.user_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN food f
ON od.f_id = f.f_id
GROUP BY name,f_name
ORDER BY COUNT(*) DESC
;