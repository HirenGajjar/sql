SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;

SELECT gender,
AVG(salary) AS ave_salary
FROM employee_demographics em_de
JOIN employee_salary em_sa
ON em_de.employee_id = em_sa.employee_id
GROUP BY gender
;

-- In above code we needed the average salary for each gender - so we did the group by and average salary. That gives us 2 * 2 table.
-- Now If we want to see the name of each employee,gender and also the average salary by gender then we can use OVER() function of window

SELECT gender,AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics em_de
JOIN employee_salary em_sa
ON em_de.employee_id = em_sa.employee_id;