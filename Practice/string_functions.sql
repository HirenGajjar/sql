SELECT * 
FROM employee_demographics;

SELECT LENGTH("Hiren") AS Name;

-- Find the length of first name and last name for demographics table

SELECT first_name, LENGTH(first_name) AS "Length Of Name"
FROM employee_demographics
ORDER BY LENGTH(first_name);

SELECT UPPER('hiren');

SELECT LOWER('HIREN');

SELECT TRIM('         hiren      ');
SELECT LTRIM('         hiren      ');
SELECT RTRIM('         hiren      ');


-- LEFT

SELECT first_name, 
LEFT(first_name,1)
FROM employee_demographics;

-- RIGHT

SELECT first_name , 
RIGHT(first_name,1)
FROM employee_demographics;

-- SUB STRINGS

SELECT first_name,
SUBSTRING(first_name,2, 2)
FROM employee_demographics;			

-- FInd out the month from the data of birth column

SELECT birth_date,
SUBSTRING(birth_date , 6,2) AS "Month"
FROM employee_demographics;

-- Replace

SELECT birth_date,
REPLACE(birth_date,'-','/')
FROM employee_demographics;

-- LOCATE

SELECT 
LOCATE('i','Hiren');

SELECT first_name ,
LOCATE('is',first_name)
FROM employee_demographics;

-- CONCAT

SELECT first_name , last_name,
CONCAT(first_name,' ',last_name) AS "full_name"
FROM employee_demographics;

