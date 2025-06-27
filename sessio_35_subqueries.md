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

### Independent Subquery - Table subquery

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

Q.2. Find the highest rated movie for each genre where the minimum votes are > 25000

1. Group By genre
2. MAX(score)
3. votes > 25000
4. Use the above results to find the name

```sql
SELECT genre,
MAX(score)
FROM movies
WHERE votes > 25000
GROUP BY genre;

SELECT *
FROM movies
WHERE (genre,score)
IN
(
SELECT genre,
MAX(score)
FROM movies
WHERE votes > 25000
GROUP BY genre
);
```

Here we can have 3 variation based on the needs

First one is the above -

_First finds the highest-rated movie (by score) for each genre, but only among movies with votes > 25000._

_Then returns all movies (from full table) that match that (genre, score). ⚠️ Caveat: It's possible that the final selected movie has less than 25,000 votes, if another movie with the same genre and score exists but fewer votes._

Second is here

```sql
SELECT *
FROM movies
WHERE (genre, score) IN
(
  SELECT genre, MAX(score)
  FROM movies
  WHERE votes > 25000
  GROUP BY genre
)
AND votes > 25000;
```

_Same as Query 1, but also filters final result to only include rows with votes > 25000. ✅ This makes sure both: The best movie per genre is chosen from high-voted movies ,The final result only includes high-voted movies too._

And the last is here

```sql
SELECT *
FROM movies
WHERE (genre, score) IN
(
  SELECT genre, MAX(score)
  FROM movies
  GROUP BY genre
)
AND votes > 25000;
```

_Finds the highest-rated movie per genre, regardless of votes. Then filters the final results to only include movies with more than 25,000 votes. ❌ This may filter out some top-rated movies per genre if they don't have enough votes — meaning you might miss the actual best one._

Q.3. Find the highest grossing movie of top 5 star-director combo as per the gorss total income

1. Group by star, director
2. Find their MAX(gross) - LIMIT 5
3. Use above table for more details

```sql
SELECT star,director
FROM movies
GROUP BY star,director
ORDER BY MAX(gross) DESC LIMIT 5;

SELECT *
FROM movies
WHERE (star,director)
IN
(
SELECT star,director
FROM movies
GROUP BY star, director
ORDER BY MAX(gross)
DESC LIMIT 5
);
```

## Correlated Subquery

Q.1. Find movies that has higher score then the average of that genre it belongs to.

Here it sounds like we can use the GROUP BY to get the average score for each genre, which is not wrong. But we will have result of genre, AVG(score) and then we need to check for each movie with two conditions, one is the genre and another one is its score that has to be > then the average.

```sql
SELECT genre,
AVG(score)
FROM movies
GROUP BY genre;
```

This gives the table for each genre and its average score value, which is no use.

So to solve the problem we need to write a query that checks the score of the movie which we are currently checking for its score with respect to its genre with the average score of that genre, you see there is a interconnection for this condition check.

For an example, Lets say we start with first movie - it has score of x, and now we need to see its genre, based on the genre we will check the average score of that genre and if the movie has score higher then the genre then we will print it.

```sql
SELECT *
FROM movies m1
WHERE score >
(
SELECT
AVG(score)
FROM movies m2
WHERE m1.genre = m2.genre
);
```

Here as we can see the m1 is our current checking movie based on its own score whereas the m2 is the average score of the genre and we compare both of them using genre.

NOW SAME Question can be solve using SELF JOIN and GROUP BY. Here is how

```sql
SELECT *
FROM movies m1
JOIN >
(SELECT genre,
AVG(score) AS 'm2_avg_score'
FROM movies
GROUP BY genre) AS m2
ON m1.genre = m2.genre
WHERE m1.score > m2.m2_avg_score;
```

Q.2. VERY IMPORTANT TO keep watching 1:28:00 to 1:37:00

We have to find out the favorite food for each person based on what they have ordered most. Using 4 tables and join - users, orders, order_details, food.

```sql
SELECT *
FROM users u
JOIN orders o
ON u.user_id = o.user_id
JOIN order_details od
ON od.order_id = o.order_id
JOIN food f
ON od.f_id = f.f_id;
```

This will give us the grand table for all the details. Now we will GROUP BY based on user_id, user name, food id ,food_name and will count the repetation

```sql
SELECT u.user_id,u.name, f.f_name,
COUNT(*) AS 'food_order_count'
FROM orders o
JOIN users u
ON o.user_id = u.user_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN food f
ON od.f_id = f.f_id
GROUP BY u.name ,f.f_name,u.user_id
ORDER BY u.name ASC ,
food_order_count DESC ;
```

Since we have the each user_id, name ,food_name and the number of time they order the food, we will use CTE (common table expression).

```sql

WITH fav_food AS(
SELECT u.user_id,u.name, f.f_name,
COUNT(*) AS 'food_order_count'
FROM orders o
JOIN users u
ON o.user_id = u.user_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN food f
ON od.f_id = f.f_id
GROUP BY u.name ,f.f_name,u.user_id
ORDER BY u.name ASC ,
food_order_count DESC )

SELECT *
FROM fav_food f1
WHERE food_order_count =
(SELECT MAX(food_order_count)
FROM fav_food f2
WHERE f2.user_id = f1.user_id
);
```

## Use based subquery

### SELECT

Q.1. Get the % of votes for each movie as compare to the total votes in the data base

1. Find the total votes
2. Calculate the %

```sql
SELECT name,
votes / (
SELECT
SUM(votes)
FROM movies) * 100
AS 'percentage_of_votes'
FROM movies
```

Q.2. Display the name of all movies, genre, score and average score

In this case it will be easy to get the name, score and genre of reach movie.

We can solve this using subquery or join as well

1. Using Subquery

```sql
SELECT name,genre,score
FROM movies;
```

But we need another column that gives the average score for each column

```sql
SELECT name, genre,score,
(SELECT
AVG(score)
FROM movies m1
WHERE m1.genre = m2.genre
)
FROM movies m2;
```

2. Now same problem can be solve using join

```sql
SELECT m1.name,m1.genre,m1.score,
m2.ave_genre_score
FROM movies m1
JOIN (
SELECT genre,
AVG(score) AS 'ave_genre_score'
FROM movies
GROUP BY genre
) AS m2
ON m1.genre= m2.genre;
```

Using the subquery inside the SELECT can be highly inefficient. @1:54:00

### FROM

Q.1. Find the average rating for each restaurant ?

```sql
SELECT r_name,
ave_ras_rate
FROM(
SELECT
r_id,
AVG(restaurant_rating)
AS 'ave_ras_rate'
FROM orders
GROUP BY r_id) t2
JOIN restaurants r
ON r.r_id = t2.r_id;
```

### HAVING

Q.1. Find genres having score > average score of all movies in dataset ? (basically using subquery to filter GROUP BY)

- Find the average of all the movies AVG(score)
- Compare that to the each genre average score using group by

```sql
SELECT genre,
AVG(score) AS 'ave_genre_score'
FROM movies
GROUP BY genre
HAVING ave_genre_score >
(
SELECT
AVG(score)
AS 'ave_score'
FROM movies
);
```

### INSERT

Q.1. Insert data into the table called 'loyal_customers' for the customers who had ordered at least 3 times or more. Consider the new table 'loyal_customers' is created.

- Do the join between users and oreders
- Group by the name and id
- Count
- Insert into the table

```sql
SELECT u.name, o.user_id
FROM orders o
JOIN users u
ON o.user_id = u.user_id
GROUP BY u.name,o.user_id
HAVING COUNT(*)> 3;
```

```sql
CREATE TABLE IF NOT EXISTS loyal_customers
(
user_id INT,
name VARCHAR(255),
money FLOAT
);
```

```sql
INSERT INTO loyal_customers
(
SELECT u.name, o.user_id
FROM orders o
JOIN users u
ON o.user_id = u.user_id
GROUP BY u.name,o.user_id
HAVING COUNT(*) > 3;
);
```

Here we do not use VALUES keyword while inserting the values as we are inserting from another table.

### UPDATE

Q.1. Now provide the 10% app money into the loyal_customers money column basd on their order value.

```sql
SELECT user_id ,
SUM(amount) AS total_spendings,
SUM(amount)/10 AS app_money
FROM orders
GROUP BY user_id ;

UPDATE loyal_customers
SET money = (
SELECT SUM(amount) / 10
FROM orders
);

SELECT *
FROM loyal_customers;
```

### DELETE

Q. Delete all the customers who never ordered.

```sql
DELETE FROM users
WHERE user_id IN (
  SELECT user_id FROM (
    SELECT u.user_id
    FROM users u
    LEFT JOIN orders o
    ON u.user_id = o.user_id
    WHERE o.amount
    IS NULL
  ) AS sub
);
```
