CREATE DATABASE IF NOT EXISTS subquery_practice;
USE subquery_practice;

CREATE TABLE IF NOT EXISTS employee (
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(50) NOT NULL,
dep_name VARCHAR(255) NOT NULL ,
salary INT NOT NULL

);

INSERT INTO employee (emp_id, emp_name, dep_name, salary) VALUES
(1, 'Alice Johnson', 'Engineering', 85000),
(2, 'Bob Smith', 'Marketing', 62000),
(3, 'Charlie Brown', 'Sales', 70000),
(4, 'Diana Prince', 'Engineering', 95000),
(5, 'Ethan Hunt', 'HR', 58000),
(6, 'Fiona Gallagher', 'Finance', 73000),
(7, 'George Costanza', 'Engineering', 88000),
(8, 'Hannah Baker', 'Sales', 67000),
(9, 'Ian Malcolm', 'R&D', 102000),
(10, 'Julia Roberts', 'HR', 60000),
(11, 'Kevin Durant', 'Engineering', 91000),
(12, 'Laura Palmer', 'Finance', 74000),
(13, 'Michael Scott', 'Sales', 65000),
(14, 'Nina Dobrev', 'Marketing', 63000),
(15, 'Oscar Wilde', 'Engineering', 87000),
(16, 'Pam Beesly', 'HR', 59000),
(17, 'Quentin Tarantino', 'R&D', 108000),
(18, 'Rachel Green', 'Sales', 68000),
(19, 'Steve Rogers', 'Engineering', 93000),
(20, 'Tina Fey', 'Finance', 76000),
(21, 'Uma Thurman', 'Marketing', 64000),
(22, 'Victor Stone', 'Engineering', 89000),
(23, 'Wendy Testaburger', 'HR', 61000),
(24, 'Xander Cage', 'R&D', 99000);

CREATE TABLE IF NOT EXISTS department (
    dep_id INT PRIMARY KEY AUTO_INCREMENT,
    dep_name VARCHAR(255) UNIQUE NOT NULL,
    manager VARCHAR(50) NOT NULL,
    budget INT NOT NULL
);


INSERT INTO department (dep_name, manager, budget) VALUES
('Engineering', 'Tony Stark', 500000),
('Marketing', 'Don Draper', 250000),
('Sales', 'Jim Halpert', 300000),
('HR', 'Leslie Knope', 200000),
('Finance', 'Gordon Gekko', 275000),
('R&D', 'Shuri', 400000);


SELECT * 
FROM employee;

SELECT *
FROM department;

-- Find all the employees who earn more than the average of all
-- Average salary
-- Filter the employees 

SELECT AVG(salary)
FROM employee;

SELECT *
FROM employee 
WHERE salary > 
(SELECT AVG(salary) FROM employee)
ORDER BY salary DESC;

-- Scalar subquery - Only returns one row and one column / Only One Record or a value

-- We can solve the above problem using join

SELECT *
FROM employee e
JOIN (SELECT AVG(salary) AS sal FROM employee  ) AS avg_sal
ON e.salary > avg_sal.sal;

-- Multiple Row subquery
-- Multi column * Multi Rows subquery
-- Single Column * Multiple Rows subquery

-- Q.2 Find the employees in each department that earns the most

-- Group by department
-- Sort by salary 

SELECT dep_name, MAX(salary)
FROM employee
GROUP BY dep_name;

SELECT emp_name ,salary 
FROM employee
WHERE (dep_name, salary) IN (SELECT dep_name, MAX(salary) FROM employee GROUP BY dep_name);


-- Single Column Multi Row subquery

-- Q.3 Find the department that does not have any employee
-- Right now we have people in each department
SELECT DISTINCT(dep_name) 
FROM employee;

SELECT *
FROM department
WHERE (dep_name) NOT IN (SELECT DISTINCT(dep_name)
FROM employee);


