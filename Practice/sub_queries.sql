SELECT *
FROM employee_demographics;
SELECT *
FROM employee_salary;
SELECT *
FROM parks_departments;

-- If we want to find out the people who works in parks and recreation department (dep - 1) without using joins, we can use subqueries

SELECT *
FROM employee_demographics
WHERE employee_id 
IN(
SELECT employee_id
FROM employee_salary
WHERE dept_id = 1
);

-- Let say our aim is to have an output that has first_name, last_name, salaray and average_salary (real average salary of all) using subqueries

SELECT first_name, last_name, salary ,
(
SELECT 
AVG(salary)
FROM employee_salary
) AS "average_salary"
FROM employee_salary
GROUP BY first_name,last_name,salary;

-- See the code below 1:39:00

SELECT gender , 
AVG(age),
MIN(age),
MAX(age),
COUNT(age)
FROM employee_demographics
GROUP BY gender;

-- Now in the same query we also want to get the average of Min age ,max age and count as well
SELECT AVG(ave_age) ,
AVG(max_age),
AVG(min_age),
AVG(count_age)
FROM 
(
SELECT gender , 
AVG(age) AS ave_age,
MAX(age) AS max_age,
MIN(age) AS min_age,
COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender
)AS aggregate_table;