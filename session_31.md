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

*Data Integrity : accuracy + completeness + consistency = It is to measure a relibility and trustworthiness of the data, dbms and application from errors, corruption and unauthrized access.*

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

```sql
CREATE TABLE IF NOT EXISTS users(
user_id INT NOT NULL,
user_name VARCHAR(255) NOT NULL,
user_email VARCHAR(255) NOT NULL UNIQUE,
user_password VARCHAR(255) NOT NULL
);
```


---

Most Important at 52:00 Session 31 ⚠

Let say we have a situation where we cannot have a combo of a name and email both are same in a row, here a same name can be repeate if the email is not repeated, but if two users are trying to add same username and email then that is not simply possible by adding UNIQUE in email and name so that is where we have to add explicitely for constrains

Here is simple way to add a constraint first

```sql
CREATE TABLE IF NOT EXISTS users(
user_id INT NOT NULL,
user_name VARCHAR(255) NOT NULL,
user_emaill VARHCAR(255) NOT NULL,
user_password VARHCAR(255) NOT NULL,

CONSTRAINT users_user_email_user_name_unique UNIQUE(user_email,user_name)

);
```

The good practice here to follow is while creating a constraint user table name first, then column names and then the constraint like users_user_email_user_name_unique(user_email,user_name).

It helps if in future where you need to remove the constraint only so you dont have to delete whole row or column , rather just remove that constraint.

---

```sql
CREATE TABLE IF NOT EXISTS users(
user_id INT NOT NULL PRIMARY KEY,
user_name VARCHAR(255) NOT NULL,
user_email VARCHAR(255) NOT NULL,
user_password VARCHAR(255) NOT NULL,
CONSTRAINT users_user_email_user_name_unique UNIQUE(user_email,user_name)
);
```

There is another way to declare a primary key in a table

```sql
CREATE TABLE IF NOT EXISTS users(
user_id INT NOT NULL,
user_name VARCHAR(255) NOT NULL,
user_email VARHCAR(255) NOT NULL,
user_password VARCHAR(255) NOT NULL,

CONSTARINT users_user_email_user_name_unique UNIQUE(user_email,user_name),
CONSTRAINT users_user_id_primary_key PRIMARY KEY (user_id)
 );
```

Why we need the second way ? - In many situations where there is no single column that is meeting all the requirements for being a primary key - then we need second way to do it, where we can make it. And second use case is we can give name to constraints - and we dont have to do directly to the attributes. At 58:00 Session 31
