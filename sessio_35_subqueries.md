# Subquery

**_use = for SCALER checks and use IN for multi dimentional results check_**

A query with in a query is a sub query.

a subquery is simply a SELECT statement that is nested inside another SQL statement such as: SELECT, INSERT, UPDATE, DELETE.

**_The Subquery is executed first._**

```sql
SELECT *
FROM movies
WHERE score > (
SELECT
MAX(score)
FROM movies
);
```

In the above code the scope of the subquery or the inner query is only until the outer query is present. Once the outer query is gone, inner query is gone.

There is mainly INNER QUERY that executed first - The result of INNER QUERY is given to OUTER QUERY.

Types of Subquery. (based on what inner query returns or based on execution)

- Based on what it returns

  - Scaler Subquery (1 Row X 1 Column)
  - Row Subquery (Multiple Rows X 1 Column)
  - Table Subquery (Multiple Rows X Multiple Column)

- Based on execution

  - Independent Subquery / Non-correlated Query
  - Correlated Subquery

⚠⚠⚠⚠

Here good thing to keep in note is that a scaler subquery can be independent or Correlated, similarly Row and Table queries can Independent or Correlated. Likewise , Independent subquery can return Scaler or Table or Row values, And so the Correlated Subqueries.

⚠⚠⚠⚠

###### Usage of Subqueries

1. INSERT
2. SELECT
   1. WHERE
   2. SELECT
   3. FROM
   4. HAVING
3. DELETE
4. UPDATE

## Based on Results

### Scaler Subquery

Returns scaler value like Number or String (single value).

### Row Subquery

Returns multiple rows in a single query.

### Table Subquery

Multiple Rows - Multiple Columns Results.

## Based on Execution

---

### Independent Subquery - Scaler value

Q.1. Let say we need to find out the movie with highest profit from the given Data.

First we can do it using simply ORDER BY.

```sql
SELECT *
FROM movies
ORDER BY (gross - budget ) DESC LIMIT 1;
```

Same problem can be solve using subquery.

```sql
SELECT *
FROM movies
WHERE (gross - profit ) = (SELECT MAX(gross - profit) FROM Movies);
```

Q.2. Find the movie in year 2000 that has the highest score

```sql
SELECT *
FROM movies
WHERE year = 2000
AND
score =
(
SELECT MAX(score)
FROM movies
WHERE year =2000
);
```

Now here something to note - we have used the year = 2000 condition twice. Why ? It is because it is a independent subquery that means the inner query's result does not have anything to do with the outer query, it will simply give use the single value of MAX(score) and for the outer query we need to check the condition again.

Q.3. Find the movies that has the higher score then the average score for the whole dataset

Find the average score for the dataset

```sql
SELECT
AVG(score)
FROM movies;
```

Now use that to filter

```sql
SELECT *
FROM movies
WHERE score > (
SELECT
AVG(score)
FROM movies
);
```

Q.4. Find the movies that has the highest score where the votes are > then the average votes for the dataset

Find the average votes for the whole dataset

```sql
SELECT
AVG(votes)
FROM movies;
```

Using the above result compare and oreder the result to DESC LIMIT 1

```sql
SELECT *
FROM movies
WHERE votes >
(SELECT AVG(votes)
FROM movies)
ORDER BY score DESC LIMIT 1;
```

Now we can solve same using nested subquery.

1. Find the average votes
2. Find all the max scores from the movies that matches the first condition
3. Use MAX(score) to filter

```sql
SELECT
AVG(votes)
FROM movies;
```

```sql
SELECT MAX(score)
FROM movies
WHERE votes > (
SELECT
AVG(votes)
FROM movies
);
```

```sql
SELECT *
FROM movies
WHERE score = (
SELECT MAX(score)
FROM movies
WHERE votes >
(
SELECT
AVG(votes)
FROM movies
)
);
```

---

### Independent subquery - Row value

One Column X Multiple Rows Resultes

Q.1. Find the users who never ordered ?

There are two ways to solve it.

1. Using JOIN
2. Subquery

```sql
SELECT *
FROM users u1
LEFT JOIN orders o1
ON u1.user_id = o1.user_id
WHERE o1.amount IS NULL;
```

Here is the subquery way to solve the same problem.

1. Find the user_id for all the users who ordered from orders table.
2. Use that to filter from users table

```sql
SELECT
DISTINCT(user_id)
FROM orders;
```

```sql
SELECT *
FROM users
WHERE user_id
NOT IN (
SELECT
DISTINCT(user_id)
FROM orders
);
```

Q.2. Find all the movies of Top 3 directors based on thier gross income of all the movies

Group by directors -> find SUM(gross) -> Sort by SUM(gross) -> LIMIT 3

```sql
SELECT director
FROM movies
GROUP BY director
ORDER BY SUM(gross)
DESC LIMIT 3;
```

Now use the names of the directors to find all of thier movies

```sql
SELECT *
FROM movies
WHERE director IN (
SELECT director
FROM movies
GROUP BY director
ORDER BY SUM(gross)
DESC LIMIT 3
);
```

Q.3. Find all the movies of top 3 actors who has average score > 8.5 and only consider movies where votes are > 25000

1. Group by actors - having avg score of 8.5
2. Filter votes > 25000
3. Use names of actors to find thier movies

```sql
SELECT *
FROM movies
WHERE votes > 25000;

SELECT star
FROM movies
WHERE votes > 25000
GROUP BY star
HAVING AVG(score) > 8.5;

SELECT *
FROM movies
WHERE star
IN (
SELECT star
FROM movies
WHERE votes > 25000
GROUP BY star
HAVING AVG(score) > 8.5
);
```

###### Independent Subquery - Table subquery

Multi Columns X Multi Column (sometimes Single Columns)

Q.1. Find the most profitable movie of the year for each year.

1. Group by year
2. Find MAX(gross - budget) for each year
3. Use that table to find more details on it

```sql
SELECT year ,
MAX(gross-budget)
FROM movies
GROUP BY year;


SELECT *
FROM movies
WHERE (year, (gross-budget)) IN
(
SELECT year,
MAX(gross - budget)
FROM movies
GROUP BY year
);
```
