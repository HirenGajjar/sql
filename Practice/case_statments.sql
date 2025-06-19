-- Consider finding employee based on age where under 30 - called them under30

SELECT first_name, last_name ,age,
CASE 
WHEN age <= 30 
THEN 'Under30'
ELSE 'Over30'
END AS 'age_group'
FROM employee_demographics;

-- USE multiple CASE 

SELECT first_name ,last_name , age,
CASE 
	WHEN age < 20 
	THEN 'Under20'
	WHEN age > 20 
	AND age <30 
	THEN '20-30'
	WHEN  age > 30 
	AND age < 40 
	THEN '30-40'
	ELSE 'Above40' 
END AS 'age_distribution'
FROM employee_demographics
ORDER BY age;

-- In salary table do following 
-- salary < 50000 - raise 5%
-- salary > 50000 - raise 7%
-- And if someone is in Finance department give 10% Bonus

SELECT * 
FROM parks_departments;

SELECT *
FROM employee_salary;

SELECT first_name, last_name,salary, department_name,
CASE 
	WHEN salary <= 50000 THEN ROUND(salary + salary * (5/100),2)
    WHEN salary > 50000 THEN ROUND(salary + salary * (7/100),2)
END as 'New Salary',
CASE
	WHEN department_name = 'Finance' THEN ROUND(salary * 10/100,2)
    ELSE 0
END AS "Bonus"
FROM employee_salary em_sa
JOIN parks_departments pa_de
ON em_sa.dept_id = pa_de.department_id;



