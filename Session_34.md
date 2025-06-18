### JOINS

https://drive.google.com/file/d/17K-6H-Vpgc2PGO547tHX9-fTyHluq8DH/view

When the data is distributed in multiple tables and we need to retrive data from them we use joins that creates a virtual table based on related columns between those tables.

_⚠ The criteria to perform join is that tables must have atleast one column common between them._

1. Left / Left Outer
2. Right
3. Inner
4. Full / Full Outer
5. Self
6. Cross

### CROSS

A = {1,2} and B = {3,4} Then Cartesian product A x B = (1,3),(1,4),(2,3),(2,4)

### INNER

Syntax - Here JOIN or INNER JOIN is same thing.

**_ONLY RETURNS THE ROWS THAT HAS THE SAME VALUES IN BOTH OF THE TABLE._**

```sql
SELECT Column
FROM first_table t1
JOIN TYPE second_table t2
ON t1.column = t2.column;
```

### LEFT / LEFT Outer

### RIGHT / RIGHT Outer

### FULL JOIN

### SET Operations

1. UNION - Combines all the uniuqe values from both sets
2. UNION ALL - It is just union with duplicated values
3. INTERSECT - Only Common item
4. EXCEPT / MINUS - Table A Except Table B will give Only values that are avaialbe in A and removes those values that are duplicated in both.

### SELF Join - Table joined itself

Same table is tretated as a two tables. It is useful to compare rows of same table.
