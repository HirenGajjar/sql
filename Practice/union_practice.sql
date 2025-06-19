USE practice;

SELECT * 
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT * 
FROM parks_departments;

SELECT *
FROM employee_demographics
UNION
SELECT * 
FROM employee_salary;




SELECT first_name, last_name
FROM employee_demographics
UNION 
SELECT first_name ,last_name
FROM employee_salary;


-- Now let say we need to find out Male above the age of 40 , Female Above the age of 40 and people getting paid above 50K

SELECT first_name ,last_name, 
"Above 40 Male" AS Label
FROM employee_demographics
WHERE age > 40 
AND gender = 'Male'

UNION

SELECT first_name, last_name,
"Above 40 Female" AS Lable
FROM employee_demographics
WHERE age > 40 
AND gender = 'Female'

UNION 

SELECT first_name ,last_name , 
"Above 50K Salary" AS Lable
FROM employee_salary
WHERE salary > 70000;

