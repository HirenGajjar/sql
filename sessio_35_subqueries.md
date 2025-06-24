# Subquery

A query with in a query is a sub query.

***The Subquery is executed first.***

There is mainly INNER QUERY that executed first - The result of INNER QUERY is given to OUTER QUERY.

Types of Subquery. (based on what inner query returns or based on execution)

* Based on what it returns

  * Scaler Subquery
  * Row Subquery
  * Table Subquery
* Based on execution

  * Independent Subquery
  * Correlated Subquery

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

Let say we need to find out the movie with highest profit from the given Data.

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

---

### Independent subquery - Row value

One Column Multiple Rows Resultes
