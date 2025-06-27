CREATE DATABASE IF NOT EXISTS window_functions;
USE window_functions;

CREATE TABLE students(
id INT PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(255) NOT NULL,
student_department VARCHAR(255) NOT NULL,
student_score INT NOT NULL
);

SELECT * 
FROM students;

INSERT 
INTO 
students (student_name, student_department,student_score) 
VALUES 
('Sam','IT',9.5),
('Ram','CS',6.5),
('Gam','IT',5.5),
('Bam','IT',8.5),
('Pam','CS',9.2),
('Fam','CS',9.4),
('Cam','CS',5.5),
('Sam','IT',6.75),
('Ham','CS',5.75),
('Xam','IT',9);

SELECT * 
FROM students;

-- Find the average of score of the students in each departments

SELECT student_department,
AVG(student_score)
FROM students
GROUP BY student_department;


-- Now we can do same using OVER() clause

-- SELECT *,
-- AVG(student_score) OVER(PARTITION BY student_department)
-- FROM students;

CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

SELECT *
FROM marks;

-- SELECT *,
-- AVG(marks) OVER(PARTITION BY branch) 
-- FROM marks;

-- Find the students who have higher marks then the average of their brach



