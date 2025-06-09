Database server - DBMS - control DBs

DBs - Tables - Rows and cols

**SQL - structured query language - language to manage and manipulate RDBMS - allows to do CRUD operations.** 

1. DDL - Data defination Language - CREATE ALTER DROP TRUNCATE
2. DCL - Data control Language - GRANT REVOKE
3. DML - Data manipulation Language - INSERT UPDATE DELETE SELECT
4. TCL - Transaction Control Language - COMMIT ROLLBACK

---



```sql
CREATE TABLE campusx;
```

 but standard practice is 

```sql
CREATE DATABASE IF NOT EXISTS campusx;
```

---



```sql
DROP DATABASE campusx;
```

but standard practice is

```sql
DROP DATABASE IF EXISTS campusx;
```


---

To create a table you must have a database.

Good practice is to keep the all the keywords capital and all the names for DB, Tables, Rows, Cols small

```sql
CREATE TABLE my_table(
user_id INT,
user_name VARCHAR(255),
user_email_address VARCHAR(255),
user_password VARCHAR(255)
);
```

---

How to empty a table - TRUNCATE

```sql
TRUNCATE TABLE my_table;
```

Here if exists does not works (atleast not in myphpadmin)

---

How to delete a table 

```sql
DROP TABLE IF EXISTS my_table;
```

Be very carefull while dropping or truncating a table - all the time ⚠
