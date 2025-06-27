CREATE DATABASE IF NOT EXISTS codeera;
USE codeera;
SHOW DATABASES;
DROP DATABASE IF EXISTS codeera;
CREATE DATABASE IF NOT EXISTS codeera;

CREATE TABLE IF NOT EXISTS users(
user_name varchar(255),
age int);

SELECT * 
FROM users;


CREATE TABLE IF NOT EXISTS employees (
id INT(10) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
salary INT(20),
department VARCHAR(50),
dob DATE
);

SELECT *
 FROM employees;
 
 SHOW TABLES;
 
 DESCRIBE employees;
 DESC employees;
 
 CREATE TABLE emp_copy_1 
 AS SELECT * FROM employees;
 
 DESC emp_copy_1;
 
 CREATE TABLE emp_copy_2
 SELECT id,name FROM employees;
 
 DESC emp_copy_2;
 
 INSERT INTO  employees (id,name,salary,department,dob) VALUES(1,
 "Hiren",10000000,"CEO",'1999/08/11');
 
 SELECT * 
 FROM employees;
 
 CREATE TABLE IF NOT EXISTS emp_copy_3
 SELECT * FROM employees
 WHERE name = "Hiren";
 
 SELECT *
 FROM emp_copy_3;
 
 
 CREATE TABLE IF NOT EXISTS emp_copy_interview_question 
 SELECT * FROM employees;
 
 DESC emp_copy_interview_question;
 
 SELECT * FROM emp_copy_interview_question;
 
 CREATE TABLE IF NOT EXISTS emp_int_que_2 (
 emp_id INT PRIMARY KEY AUTO_INCREMENT,
 emp_name VARCHAR(255) NOT NULL,
 emp_depratment VARCHAR(255) NOT NULL,
 emp_salary INT NOT NULL,
 age INT NOT NULL
 );
 
 SELECT * 
 FROM emp_int_que_2;
 
 
 INSERT INTO employees
 (id,name,salary,department,dob)
 VALUES 
 (102,"KRUPA",20000000,"WIFE",'1999-1-1');
 
 SELECT *
 FROM employees;
 
 INSERT INTO employees
 VALUES 
 (
 103, "Love",2000001001,"Lovers",'2025-12-12'
 );
 
 SELECT *
 FROM employees;
 
 INSERT INTO employees
 (id,name,department)
 VALUES
 (
 144,"Popat","chachcha"
 );
 
 SELECT *
 FROM employees;
 
 
 INSERT INTO employees 
 (id,name,salary,department,dob)
 VALUES
 (444,"d",22,"ads",'1999-2-2'),
 (4445,"d3",232,"adasds",'1999-2-22')
 ;
 
 SELECT *
 FROM employees;
 
 
 