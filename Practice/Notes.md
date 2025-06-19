#### SELECT

We can do calculation or basic math operations with in SELECT statment. For an exmaple we have a column called 'age' that stores the integer values like 10,12, or 20 then we can do simply

```sql
SELECT name, age ,age+10
FROM database_name.table_name;
```

#### Comments

```sql
# Commnets

-- Comments Too
```

#### Operators

PEMDAS - MYSQL supports Paranthesis, Exponents (Power), Multiplication & Division, Addition and Subtraction.

```sql
SELECT age , (age + 10 ) * 10
FROM database_name.table_name;
```

#### DISTINCT & WHERE

DISTINCT - select Unique values in the perticular column.

SELECT is use for select and filter columns. WHERE is use for filter rows.

Comparision operators **= < > <= >= !=**

Logical Operators **AND OR NOT**

#### LIKE % \_

LIKE - LIKE comes with two values % means everything and \_ Specific.

```sql
SELECT *
FROM database_name.table_name
WHERE name LIKE 'Hir%';
```

Here the query will return all the names that starts with Hire as first 3 characters where it may or may not have any other characters, also if it has other characters then it can be anything(%).

Similarly if we have to find out all the names that containts the character or string like "ire" in the name at any position, we can use multiple %. Here is how

```sql
SELECT *
FROM database_name.table_name
WHERE name LIKE '%ire%';
```

This will return all the names that cotaints 'ire' in it followed or being followed by anything.

Now let say if we have to find out the names that start with 'a' and has very specifically two characters after. Like "Ann" or "ann". In that case we can use \_.

```sql
SELECT *
FROM database_name.table_name
WHERE name LIKE 'A__';
```

This will return all the names start with A or a that have only two characters after it.

Both % and \_ are not limited to strings, we can use them for all use case. For an example date.

Let say we need to find out the people born in year 1999.

```sql
SELECT *
FROM database_name.table_name
WHERE birth_date LIKE '1999%';
```

This will return each row that has a data of birth 1999. Note that we consider the data saved in yyyy-mm-dd manner.

#### GROUP BY

We can only SELECT the columns that are aggregated in table with GROUP BY. What does that means is, let say we have data of name, gender, age and date of birth. Now if we group by gender and do select with name then it will give us error because assuming gender has only two values Male and Female, hence we grouped our data in two categories but we want table to return names which are not aggregated in any manner. In other words we may have 10 names to select but we said that we need data based on GROUP BY clause with two genders only.

At the same time if we do AVG(age) with seelcting gender and grouped by gender our query runs perfectly. Why because we basically said that group data based on gender then retrun the average age of that gender.

```sql
SELECT gender, AVG(age)
FROM database_name.table_name
GROUP BY gender;
```

Similarly, we can get the other aggregated values like MAX(age), MIN(age) and COUNT(\*) or COUNT(age).

#### ORDER BY

We use order by to sort data in ascending or descending order. Where ASC is default order.

We can simply sort the data using one column. For an example Age. Or using Name or ID.

```sql
SELECT *
FROM database_name.table_name
ORDER BY age;
```

This will sort the data by age, youngest to oldest.

We can also sort data using multiple columns. For an example we want to sort data first for gender, and then with age. So get all the FEMALE first and then sort data based on age.

```sql
SELECT *
FROM database_name.table_name
ORDER BY gender, age;
```

Considering the default value ASC. We can change either or both with DESC.

⚠⚠⚠ Not the good practice, but if we know the column name of which we want to sort the data then we dont need to use column name, we can simply use the column number (starts with 1 to N). For an example, above the gender column is at 4th position and age is at 7th then we can simply write:

```sql
SELECT *
FROM database_name.table_name
ORDER BY 4,7;
```

Althought, it is not recommended practice at all.

#### HAVING vs WHERE

**FROM, WHERE, GROUP BY, HAVING, SELECT, DISTINCT, ORDER BY and LIMIT**

There is a very specific order of execution that is followed in SQL in general, by which if we try to do following

```sql
SELECT gender, AVG(age)
FROM database_name.table_name
WHERE AVG(age) > 40
GROUP BY gender;
```

Then we will get an error. Why Because we are trying to put the condition with SELECT AVG(age) before GROUP BY get Execute. Since the order of execution tells us that GROUP BY get executed first and then SELECT it creates the confilt. And when we try to filter with WHERE cluse using condition, that hasn't created yet. To overcome that we have the HAVING clause.

```sql
SELECT gender, AVG(age)
FROM database_name.table_name
GROUP BY gender
HAVING AVG(age) > 40;
```

#### LIMIT & ALIASING

Out of millions of row of we need only first 5 without any filtering condition then we can simply use LIMIT.

```sql
SELECT *
FROM database_name.table_name
LIMIT 5;
```

LIMIT can take two arguments. x and y. Where x (offset) is the starting number of row and y (count) is the rows after the starting row to go for. So if i say LIMIT 3,5 - what does that mean is start with 3rd row and gor for next 5 rows which excludes the 3rd and goes for 4th, 5th, 6th, 6th and 8th.

LIMIT 3,5 also can be interpreted as ignore first 3 take next 5.

##### Aliasing

Aliasing can be use for change the name of column in general.

```sql
SELECT name ,AVG(age) AS average_name
FROM database_name.table_name;
```

## JOINS

Inner joins - Outer Joins and Self Joins

_Joins can be done between table using the columns that have same values (not necessarily having same column name)_

##### Inner Join

Returns the rows that are same in both columns of all tables that we joined.

```sql
SELECT *
FROM practice.employee_demographics
JOIN practice.employee_salary
ON practice.employee_demographics.employee_id = practice.employee_salary.employee_id;
```

Here we will get all the rows that have same values based on the column we specified in ON operator which is employee_id here. Remember not all the values. Only those who have the same values in provided column in both of the tables.

Now here one thing to note is that since we are trying to get all the columns once we created the join. But what happen if we want to get very specific columns from each table. Then we simply need to give the table_name.column_name instead of directly writing column_name in select statment. Here is how, also we will use Aliasing to simplify the code little bit.

```sql
SELECT em_de.first_name, em_de.last_name, em_de.salary
FROM practice.employee_demographics AS em_de
JOIN practice.employee_salary AS em_sa
ON em_de.employee_id = em_sa.employee_id
```

##### Outer Joins

###### Left Outer / LEFT join

Take everything from the left table and compare to the next table.

```sql
SELECT *
FROM practice.employee_demographics AS em_de
LEFT JOIN practice.employee_salary AS em_sa
ON em_de.employee_id = em_sa.employee_id;
```

###### RIGHT JOIN / RIGHT OUTER JOIN

Take everything from the right table and compare to the next table.

```sql
SELECT *
FROM practice.employee_demographics AS em_de
RIGHT JOIN practice.employee_salary AS em_sa
ON em_de.employee_id = em_sa.employee_id;
```

---

_Notes for JOIN in broader view_

let say i have table A that has 10 rows and table B has 10 rows

A and B has 7 matching rows with one column that is for table A - a_id and for B - b_id

so i do inner join - "I only get those 7 matching values rows using a_id and b_id"
if i do left join - "I get all the 10 rows of A and null in place for B"
if i do right join "I got all the 10 rows of B and NULL for in place of A"

---

##### SELF Join

Joining the table to it self.

```sql
SELECT *
FROM database_name.the_only_table as table_as_one
JOIN database_name.the_only_table as table_as_two
ON table_as_one.column_name = table_as_two.column_name;
```

##### Joining Multiple Tables

Consider the following task : For Parks and Recreation Database, we need first name ,last name , employee id ,salary and department for each employee.

Note here that the firt table employee_demographics has one value missing - id 2.

```sql
SELECT *
FROM practice.employee_demographics AS em_de
RIGHT JOIN practice.employee_salary AS em_sa
ON em_de.employee_id = em_sa.employee_id
JOIN practice.parks_departments AS pa_de
ON em_sa.dept_id = pa_de.dept_id;
```

The above query will get all the values. And here we will have two options to get first name and last name, either from demographics table or salary table but we choose salary table as choosing from demographics table will give NULL values for id - 2.

```sql
SELECT em_de.employee_id AS "Employee ID",
em_sa.first_name AS "Employee First Name",
em_sa.last_name AS "Employee Last Name",
em_de.age AS "Employee Age",
em_sa.salary "Employee Salary",
pa_de.department_name AS "Employee Department"
FROM practice.employee_demographics AS em_de
RIGHT JOIN practice.employee_salary AS em_sa
ON em_de.employee_id = em_sa.employee_id
JOIN practice.parks_departments AS pa_de
ON em_sa.dept_id = pa_de.department_id;
```

## UNIONS

##### Union

By default UNION is UNION DISTINCT

```sql
SELECT first_name,last_name
FROM employee_demographics
UNION
SELECT first_name,last_name
FROM employee_salary;
```

## String Functions

Build in functions to work with strings.

#### LENGTH()

```sql
SELECT LENGTH("Hiren");
```

#### UPPER()

```sql
SELECT UPPER('hiren');
```

#### LOWER()

```sql
SELECT LOWER('HIREN');
```

#### TRIM

##### TRIM - Normal

```sql
SELECT TRIM('     hiren           ');
```

##### TRIM LEFT

```sql
SELECT LTRIM('     hiren    ');
```

##### TRIM RIGHT

```sql
SELECT RTRIM('            hiren                ');
```

#### LEFT()

Let say in with name column we need to create a sort sub name, for an example Name Chris should have 3 charactres in new column as 'Chr' and so on.

```sql
SELECT first_name , 
LEFT(first_name,3)
FROM employee_demographics;
```

Similarly, if we provide the value 1 in LEFT - it will give us the first character from LEFT.

#### RIGHT()

Let say we need last two characters of last name from demographics table.

```sql
SELECT last_name , 
RIGHT(last_name,2)
FROM employee_demographics;
```

#### SUBSTRING()

Syntax - SUBSTRING(column_name, first , length)

```sql
SELECT first_name,
SUBSTRING(last_name, 2,2)
FROM employee_demographics;
```

Start at 2 and go for 3 (2 and 3 basically).

Q.FInd out the month from the date of birth column ?

```sql
SELECT birth_date,
SUBSTRING(birth_date,6,2) AS "Month"
FROM employee_demographics;
```

#### REPLACE()

Q. Replace - in date of birth column to / 

```sql
SELECT birth_date,
REPLACE(birth_date,'-','/')
FROM employee_demographics;
```

#### LOCATE()

To find something in the string. It provides the location of the given character of string in searched string.

Q. FInd i in 'Hiren'

```sql
SELECT 
LOCATE('i','Hiren');
```

It will give answer as 2 as we said find 'i' in 'Hiren' which is at 2nd postition (starting from 1-H, 2-i....)
