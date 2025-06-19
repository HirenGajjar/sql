USE sample_data;

SELECT * 
FROM groups;


SELECT *
FROM membership;

SELECT *
FROM users1;

SELECT *
FROM students;

-- Cross join groups * users1

SELECT *
FROM groups g
CROSS JOIN users1 u ;

-- Inner join users and membership

SELECT *
FROM users1 u1
INNER JOIN membership m
ON u1.user_id = m.user_id
ORDER BY u1.user_id;


SELECT *
FROM membership m
JOIN users1 u 
ON m.user_id = u.user_id
ORDER BY u.user_id;

-- LEFT Join
-- Membership table on left
SELECT * 
FROM membership m
LEFT JOIN users1 u1
ON m.user_id = u1.user_id
ORDER BY u1.user_id;

-- Users1 table on left
SELECT *
FROM users1 u1
LEFT JOIN membership m
ON m.user_id = u1.user_id
ORDER BY u1.user_id;


-- Right Join
-- Membership table on right
SELECT *
FROM users1 u1
RIGHT JOIN membership m
ON u1.user_id = m.user_id
ORDER BY u1.user_id;


-- Users1 table on right

SELECT * 
FROM membership m
RIGHT JOIN users1 u
ON m.user_id = u.user_id
ORDER BY u.user_id;


-- FULL JOIN 

SELECT *
FROM membership m
LEFT JOIN users1 u1
ON m.user_id = u1.user_id

UNION

SELECT * 
FROM membership m
RIGHT JOIN users1 u1
ON m.user_id = u1.user_id;

SELECT *
FROM person1 

UNION 

SELECT * 
FROM person2;

SELECT *
FROM person1
UNION ALL 
SELECT *
FROM person2;

-- SELF JOIN

SELECT u1.name , u2.name
FROM users1 u1
JOIN users1 u2
ON u1.emergency_contact = u2.user_id;
