USE s_35_practice;

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

SELECT *,
AVG(marks) 
OVER() 
AS "Overall Average"
FROM marks;

SELECT branch,
AVG(marks)
FROM marks
GROUP BY branch;


SELECT * , 
AVG(marks)
OVER(PARTITION BY branch) 
AS 'branch_average'
FROM marks;

-- Find the average marks for each branch.

SELECT AVG(marks)
FROM marks
GROUP BY branch;

SELECT *, 
AVG(marks)
OVER(PARTITION BY branch)
FROM marks;

-- Count the number of students in each branch.

SELECT branch,COUNT(*) 
FROM marks
GROUP BY branch;

SELECT *,
COUNT(*) 
OVER(PARTITION BY branch)
FROM marks;

-- Get the maximum and minimum marks in each branch.

SELECT *,
MAX(marks) 
OVER(PARTITION BY branch) 
AS 'highest_marks',
MIN(marks)
OVER(PARTITION BY branch)
AS 'lowest_marks'
FROM marks;

SELECT branch,
MAX(marks) 
AS 'highest_marks',
MIN(marks)
AS 'lowest_marks'
FROM marks
GROUP BY branch;

-- List all branches along with their total marks.

SELECT branch,
SUM(marks)
FROM marks
GROUP BY branch;

SELECT *,
SUM(marks) 
OVER(PARTITION BY branch)
FROM marks
ORDER BY branch;

-- 5. Find the number of students who scored more than 80 in each branch.

SELECT DISTINCT(branch),
COUNT(*)
OVER(PARTITION BY branch)
FROM marks
WHERE marks > 80;

SELECT branch,
COUNT(*)
FROM marks
WHERE marks> 80
GROUP BY branch;


-- Show each student’s marks and the average marks of their branch using a window function.

SELECT *,
AVG(marks)
OVER(PARTITION BY branch)
FROM marks;

-- Show each student’s marks along with the highest and lowest marks in their branch using OVER().

SELECT *,
MIN(marks) 
OVER(PARTITION BY branch) 
AS 'min',
MAX(marks) 
OVER(PARTITION BY branch) 
AS 'max'
FROM marks;



-- Show total marks per branch next to each student without reducing rows.

SELECT *,
SUM(marks) 
OVER(PARTITION BY branch)
AS 'total_branch_marks'
FROM marks;


-- Find the top 2 students per branch using window functions.

SELECT *,
MAX(marks) 
OVER(PARTITION BY branch)
AS 'branch_max'
FROM marks;

SELECT *,
MIN(marks)
OVER()
AS 'overall_min',
MAX(marks)
OVER()
AS 'overall_max',
MIN(marks) 
OVER(PARTITION BY branch)
AS 'branch_min_marks',
MAX(marks)
OVER(PARTITION BY branch)
AS 'branch_max_marks'
FROM marks;

-- Find all the students in each branch having marks > avg of branch
SELECT *
FROM (
SELECT *,
AVG(marks) 
OVER(PARTITION BY branch)
AS 'branch_avg'
FROM marks) t
WHERE t.marks > t.branch_avg;

-- Rank the student in each branch based on the marks

SELECT *,
RANK() 
OVER(PARTITION BY branch ORDER BY marks DESC) 
FROM marks;

SELECT *,
RANK()
OVER(ORDER BY marks DESC)
FROM marks;

SELECT *,
RANK()
OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;

-- Now Rank students based on marks - one for their branch , two for overall 

SELECT *,
RANK()
OVER(ORDER BY marks DESC) 
AS 'overall_rank',
RANK()
OVER(PARTITION BY branch ORDER BY marks DESC)
AS 'branch_rank'
FROM marks;

-- 1. Give dense_rank for each student on whole dataset
-- 2. give dense rank for each stundet based on branch
-- 3. give dense rank for both of the above

SELECT *,
DENSE_RANK() 
OVER(ORDER BY marks) 
AS 'overall_dense_rank'
FROM marks;

SELECT *,
DENSE_RANK()
OVER(PARTITION BY branch ORDER BY marks)
AS 'branch_dense_rank'
FROM marks;

SELECT *,
DENSE_RANK()
OVER(PARTITION BY branch ORDER BY marks)
AS 'branch_dense_rank',
DENSE_RANK()
OVER(ORDER BY marks)
AS 'branch_dense_rank'
FROM marks;

SELECT *,
ROW_NUMBER()
OVER() 
AS 'row_number'
FROM marks;

SELECT *,
ROW_NUMBER()
OVER(PARTITION BY branch)
AS 'branch_row_number'
FROM marks;

SELECT *,
ROW_NUMBER()
OVER(PARTITION BY branch) 
AS 'branch_row_number',
ROW_NUMBER()
OVER()
AS 'overall_row_number'
FROM marks;

-- Make a student_unique_code that is barnch name + overall row number

SELECT *,
ROW_NUMBER()
OVER() 
AS 'overall_row_number',
CONCAT(branch,'_',ROW_NUMBER() OVER() )
FROM marks;

-- Make each student unique email that is 'studentid.name.branch' 

SELECT *,
CONCAT(name,'.',branch,'@mail.com')
AS 'student_email'
FROM marks;

SELECT *,
CONCAT(name,'.',branch,'@mail.com') 
AS 'email'
FROM marks;

-- Find the top 2 most paying cutomers for each month

SELECT *
FROM orders
ORDER BY date;

SELECT 
SUBSTRING(date,5,3) AS 'month'
FROM orders;

SELECT 
MONTH(date),
MONTHNAME(date)
FROM orders;

SELECT *
FROM
(SELECT user_id,
MONTH(date) AS 'mm',
SUM(amount) AS 'spending',
RANK()
OVER(PARTITION BY MONTH(date) ORDER BY SUM(AMOUNT) DESC) 
AS 'rank'
FROM orders
GROUP BY user_id ,MONTH(date)) t1
WHERE t1.rank <= 2;

SELECT *
FROM (
SELECT user_id,
MONTH(date) AS 'month',
SUM(amount) AS 'total',
RANK()
OVER(PARTITION BY MONTH(date)
ORDER BY SUM(AMOUNT) ) AS 'month_rank'
FROM orders
GROUP BY user_id , MONTH(date)) t
WHERE t.month_rank < 3;

SELECT *
FROM marks;

SELECT *,
FIRST_VALUE(name)
OVER(ORDER BY marks DESC ) 
AS 'topper_name'
FROM marks; 

-- Find the overall data topper

SELECT *,
FIRST_VALUE(name)
OVER(ORDER BY marks DESC) 
AS 'topper_name'
FROM marks
LIMIT 1;

SELECT *,
PERCENT_RANK()
OVER(PARTITION BY branch ORDER BY marks ASC) * 100
FROM marks
ORDER BY branch , marks DESC;

SELECT *,
FIRST_VALUE(marks)
OVER(PARTITION BY branch 
ORDER BY marks DESC) 
AS 'highest_marks_for_each_branch'
FROM marks;

SELECT *,
LAST_VALUE(marks)
OVER(PARTITION BY branch ORDER BY marks DESC)
AS 'new_unknow_row'
FROM marks
ORDER BY branch, marks ASC;

SELECT *,
LAST_VALUE(marks)
OVER(PARTITION BY branch
ORDER BY marks ASC
) AS 'last_in_branch'
FROM marks;

SELECT *,
LAST_VALUE(marks)
OVER(PARTITION BY branch
ORDER BY marks ASC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS 'last_in_branch'
FROM marks;

SELECT *,
LAST_VALUE(marks)
OVER(PARTITION BY branch 
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
FROM marks;


SELECT *,
LAST_VALUE(marks)
OVER(PARTITION BY branch 
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS 'last_in_branch'
FROM marks
ORDER BY branch ,
marks DESC;

-- Find the student name and his marks in overall database who has the lowest marks

SELECT *,
LAST_VALUE(name)
OVER(ORDER BY marks DESC 
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
AS 'name_of_last_of_all',
LAST_VALUE(marks)
OVER(ORDER BY marks DESC 
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'mark_of_last_of_all'
FROM marks;

-- Now find the last in each branch , give name and score

SELECT *,
LAST_VALUE(name)
OVER(PARTITION BY branch
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'name_of_last_in_branch',
LAST_VALUE(marks)
OVER(PARTITION BY branch
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'marks_of_last_in_branch'
FROM marks ;

-- Now partition by the branch , order by the marks from low to high and make a new row that adds the score of each studnent based on the order 

SELECT *,
NTH_VALUE(marks,2)
OVER(PARTITION BY branch
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks
ORDER BY branch, marks DESC;

SELECT *,
NTH_VALUE(marks,6)
OVER(PARTITION BY branch
ORDER BY marks DESC
RANGE BETWEEN
UNBOUNDED PRECEDING 
AND 
UNBOUNDED FOLLOWING)
FROM marks;

SELECT *,
NTH_VALUE(marks,2)
OVER(PARTITION BY branch
ORDER BY marks ASC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
FROM marks
ORDER BY branch, marks ASC;

SELECT *,
NTH_VALUE(marks,2)
OVER(PARTITION BY branch 
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS '2nd_from_top',
NTH_VALUE(marks, 2)
OVER(PARTITION BY branch
ORDER BY marks ASC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS '2nd_lowest'
FROM marks
ORDER BY branch , marks DESC;


-- Write a mega query that gives the following columns
-- marks , name topper of whole data 
-- marks , name of last in whole data
-- 2nd highest name, marks in whole data
-- 2nd lowest name, marks in whole data
-- marks , name topper of each branch
-- marks , name of last in eahc branch
-- 2nd highest name, marks in each branch
-- 2nd lowest name, marks in each branch

SELECT *,
FIRST_VALUE(marks)
OVER(ORDER BY marks DESC)
AS 'topper_marks_overall',
FIRST_VALUE(name)
OVER(ORDER BY marks DESC)
AS 'topper_name_overall',
NTH_VALUE(marks,2)
OVER(ORDER BY marks DESC 
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS '2nd_from_top_marks_overall',
NTH_VALUE(name,2)
OVER(ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS '2nd_topper_name_overall',
LAST_VALUE(marks)
OVER(ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'overall_last_marks',
LAST_VALUE(name)
OVER(ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'overall_last_name',
NTH_VALUE(marks,2)
OVER(ORDER BY marks ASC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS '2nd_last_overall_marks',
NTH_VALUE(name,2)
OVER(ORDER BY marks ASC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS '2nd_last_overall_name',
FIRST_VALUE(marks)
OVER(PARTITION BY branch ORDER BY marks DESC) 
AS 'branch_topper_marks',
FIRST_VALUE(name)
OVER(PARTITION BY branch ORDER BY marks DESC)
AS 'branch_topper_name',
LAST_VALUE(marks)
OVER(PARTITION BY branch ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
AS 'last_in_branch_marks',
LAST_VALUE(name)
OVER(PARTITION BY branch ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'last_in_branch_name',
NTH_VALUE(marks,2)
OVER(PARTITION BY branch ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
AS '2nd_top_in_branch_marks',
NTH_VALUE(name,2)
OVER(PARTITION BY branch ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
AS '2nd_top_in_branch_name',
NTH_VALUE(marks,2)
OVER(PARTITION BY branch ORDER BY marks ASC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS '2nd_last_in_branch_marks',
NTH_VALUE(name,2)
OVER(PARTITION BY branch ORDER BY marks ASC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
AS '2nd_;lowest_in_branch_name'
FROM marks;

SELECT name,branch,marks
FROM (
SELECT *,
FIRST_VALUE(marks)
OVER(PARTITION BY branch 
ORDER BY marks DESC) 
AS 'topper_marks',
FIRST_VALUE(name)
OVER(PARTITION BY branch 
ORDER BY marks DESC)
AS 'topper_name'
FROM marks) t 
WHERE t.name = t.topper_name 
AND t.marks = t.topper_marks;

SELECT name,branch,marks
FROM (
SELECT *,
LAST_VALUE(marks)
OVER(PARTITION BY branch 
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
AS 'last_marks',
LAST_VALUE(name)
OVER(PARTITION BY branch
ORDER BY marks DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'last_name'
FROM marks) t
WHERE t.name = t.last_name 
AND t.marks = t.last_marks;

SELECT *,
FIRST_VALUE(marks)
OVER top_data
AS 'tooper_marks',
FIRST_VALUE(name)
OVER top_data
AS 'topper_name'
FROM marks
WINDOW top_data 
AS (PARTITION BY branch ORDER BY marks DESC) ;

SELECT *,
FIRST_VALUE(marks)
OVER top_data
AS 'topper_marks',
FIRST_VALUE(name)
OVER top_data
AS 'topper_name'
FROM marks
WINDOW  top_data 
AS (PARTITION BY branch ORDER BY marks DESC);


SELECT *,
LAG(marks)
OVER(ORDER BY student_id)
AS 'previous_student_marks'
FROM marks;

SELECT *,
LEAD(marks)
OVER(ORDER BY student_id)
AS 'marks_of_next'
FROM marks;

SELECT *,
LEAD(marks)
OVER(ORDER BY student_id)
AS 'next_student_marks'
FROM marks;

SELECT *,
LEAD(marks)
OVER(PARTITION BY branch ORDER BY marks)
AS 'lead_branch_marks',
LAG(marks)
OVER(PARTITION BY branch ORDER BY marks)
AS 'lag_branch_marks'
FROM marks;

SELECT *
FROM orders;

SELECT 
MONTHNAME(date) 
AS mm,
SUM(amount)
AS eanrings,
LEAD(SUM(amount))
OVER(ORDER  BY MONTHNAME(date) )
AS 'last_month',
((SUM(amount) - (LEAD(SUM(amount)) OVER(ORDER BY MONTHNAME(date)))) / (LEAD(SUM(amount)) OVER(ORDER BY MONTHNAME(date))) ) * 100 AS '%'
FROM orders
GROUP BY MONTHNAME(date) 
ORDER BY mm DESC;

SELECT 
SUM(amount),
MONTHNAME(date)
FROM orders
GROUP BY MONTHNAME(date);

SELECT 
SUM(amount),
MONTH(date),
LAG(SUM(amount))
OVER(ORDER BY MONTH(date))
AS 'last_month_earnings',
((SUM(amount) - 
LAG(SUM(amount))
OVER(ORDER BY MONTH(date)) ) /
LAG(SUM(amount))
OVER(ORDER BY MONTH(date)) )
* 100
AS '%'
FROM orders
GROUP BY MONTH(date);





