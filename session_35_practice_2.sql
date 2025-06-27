CREATE DATABASE joins_practice;
USE joins_practice;

SELECT *
FROM membership;

SELECT *
FROM users1;

SELECT *
FROM groups;

SELECT COUNT(*)
FROM users1
CROSS JOIN groups;

SELECT COUNT(*)
FROM users1 u1
JOIN membership m
ON u1.user_id = m.user_id;

SELECT *
FROM membership m
LEFT JOIN users1 u1
ON m.user_id = u1.user_id;

 