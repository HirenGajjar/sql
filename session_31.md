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

---

_Data Integrity : accuracy + completeness + consistency = It is to measure a relibility and trustworthiness of the data, dbms and application from errors, corruption and unauthrized access._

1. Constrains (Rules) - conditions
2. Transactions - Example of Bank transactions - a unit of work either executed whole or not at all.
3. Normalization - Design method to reduce redenduncy, and maintain consistency.

---

**Constrains**

1. NOT NULL
2. UNIQUE
3. PRIMARY KEY
4. AUTO INCREAMENT
5. CHECK
6. DEFAULT
7. FOREIGN KEY

```sql
CREATE TABLE users (
user_id INT NOT NULL,
user_name VARCHAR(255) NOT NULL,
user_email VARCHAR(255) NOT NULL,
user_password VARHCAR(255) NOT NULL
)
```
