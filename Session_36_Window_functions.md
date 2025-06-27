# Window Functions

Lets say we have a table called 'students' - that has id, name, department, and score. We have 10 students and each has id, name, department and score. There are mainly 2 departments - IT and CS. Our goal is to find the average score of students in each department. To achieve that we use GROUP BY.

```sql
SELECT department, AVG(score)
FROM students
GROUP BY department;
```

This will give us 2 columns x 2 rows table in which we can see the departments (IT,CS) and average score of students in that department.

Now we can do same thing using window function and OVER() clause. Here is what it does.

```sql
SELECT *,
AVG(score) OVER(PARTITION BY score)
FROM students;
```

Here the output will be 5 Columns and 10 rows. Why ? We will have entire row of id, name, departments and scores as it is and we will have new column called 'AVG(score) OVER(PARTITION BY score)' that will give the average score of perticular student based on the department.

This is the fundamental differnce between GROUP BY and OVER() clause. Group by give table that has all the distinct departments and its aggregated values (in this case departmens and AVG(score)), whereas OVER() using PARTITION BY cluse will give use the table that carries all the old values as well as adds new column for each row with aggregated values (in this case the)

## OVER() and Aggregation

Now we have the marks table which has a similar data to students with more rows.

Here we can do the average of each student based on their department/branch.

```sql
SELECT *,
AVG(marks) OVER(PARTITION BY branch)
FROM marks;
```

Similarly, we can do all the other aggregated function with OVER()

```sql
SELECT *,
MAX(marks) OVER(PARTITION BY brach)
FROM marks;

SELECT *,
MIN(marks) OVER(PARTITION BY brach)
FROM marks;

SELECT *,
SUM(marks) OVER(PARTITION BY brach)
FROM marks;

SELECT *,
COUNT(marks) OVER(PARTITION BY brach)
FROM marks;

-- Or

SELECT *,
MAX(marks) OVER(PARTITION BY branch),
MIN(marks) OVER(PARTITION BY branch),
SUM(marks) OVER(PARTITION BY branch)
FORM marks;
```

Similarly if we don't define the PARTITION BY in window function that it will give us the aggreageted values for whole table

```sql
SELECT *,
MAX(marks) OVER(),
MIN(marks) OVER(),
SUM(marks) OVER()
FROM marks;
```

And we can do both within a same query

```sql
SELECT *,
MAX(marks) OVER(PARTITION BY branch),
MIN(marks) OVER(PARTITION BY branch),
SUM(marks) OVER(PARTITION BY branch),
MAX(marks) OVER(),
MIN(marks) OVER(),
SUM(marks) OVER()
FROM marks;
```

## RANK()
