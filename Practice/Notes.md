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
