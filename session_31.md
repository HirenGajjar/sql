Database server - DBMS - control DBs

DBs - Tables - Rows and cols

### **SQL - structured query language - language to manage and manipulate RDBMS - allows to do CRUD operations.**

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

### **Constrains**

1. NOT NULL - cannot be null
2. UNIQUE - have to be unique for each row
3. PRIMARY KEY - Unique, not null
4. AUTO INCREAMENT - incerases by 1. Generally int values
5. CHECK - for conditional checks (an age must be between 6 to 20)
6. DEFAULT - set default value if not provided
7. FOREIGN KEY - primary key of a parent table can be use in another table (child table) to create foreign key

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

---

```sql
CREATE TABLE IF NOT EXISTS users(
user_id INT PRIMARY KEY AUTO_INCREMENT,
user_name VARCHAR(255) NOT NULL,
user_email VARCHAR(255) NOT NULL UNIQUE,
user_password VARCHAR(255) NOT NULL
);
```

---

The next one is CHECK - let say in a table called student we only allowed student under 20 and over 6 - then we can use CHECK

```sql
CREATE TABLE IF NOT EXISTS students(
students_id INT PRIMARY KEY AUTO_INCREMENT,
students_name VARCHAR(255) NOT NULL,
students_age INT NOT NULL CHECK(students_age > 6 AND students_age < 20)
);
```

Another way is to user constraint keyword.

```sql
CREATE TABLE IF NOT EXISTS students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(255) NOT NULL,
student_age INT NOT NULL,
CONSTRAINT students_student_age_check CHECK(student_age > 6 AND student_age < 20)
);
```

---

In mysql - we cannot define DEFAULT to any column using CONSTRAINT - we have to do it right away when we create that column

```sql
CREATE TABLE IF NOT EXISTS trial(
trial_id INT PRIMARY KEY AUTO_INCREMENT,
trial_name VARCHAR(255) NOT NULL,
trial_country VARCHAR(255) NOT NULL DEFAULT "INDIA"
);
```

---

Let say we created a table called customers - that has

```sql
CREATE TABLE IF NOT EXISTS customers (
c_id INT PRIMARY KEY AUTO_INCREMENT,
c_name VARCHAR(255) NOT NULL,
c_email VARCHAR(255) UNIQUE NOT NULL
);
```

Here we have Primary key of table which is c_id

Now we have another table called orders

```sql
CREATE TABLE IF NOT EXISTS orders(
o_id INT PRIMARY KEY AUTO_INCREMENT,
o_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
cid INT NOT NULL,

CONSTRAINT orders_foreign_key FOREIGN KEY (cid) REFERENCES customers(c_id)
);
```

Here the order tables have primary key o_id , and cid in customer table is a column that has a references from customer table with primary key c_id - that is why we used constraint that helps us creating foreign key in order table.

The Biggest Benifit of having a foreign key is if we try to drop a customer table while order table still exists then it wont let us do that because we have relation between those two table using foreign key.

Not only that but let say if we have two customers data in customer table - one that has made an order and one has not. Then now if we try to simply delete the cutomer with order - we will not be able to do - for that we need to delete the order it self first. But the cutomer without any order can be deleted from cutomers table.

---

In short all of the above 7 constraints we learn are here to maintain data integrity - with refrencial actions.

### REFRENCIAL ACTION

- While manipulating one table - what will be the effects on the releted tables is called RA.

The refrencial actions contains RESTRICT, CASCADE, SET NULL and SET DEFAULT.

The default nature of SQL in most cases is restrict - that means do not allow any manipulation in related tables.
Cascade on the other hand, if we create cascade in columns then change in parent table (where cascade is defined) will reflect in child table as well.

CASCADE - In below example we have customer table - where the c_id is primary key with auto increment, c_name not null and unique not null c_email. Then we have orders table - that has o_id primary key with auto increament, c_id int (Here we cannot make c_id NOT NULL that is the error if we want to use the ON DELETE SET NULL constraint at 1:34:00) and o_date time, we created forign key of c_id.

Now we can use ON UPDATE CASCADE and ON DELETE CASCADE - that means if we delete customer from customers table it will automatically delete the orders of that customer in orders table.

```sql
CREATE TABLE IF NOT EXISTS customers(
c_id INT PRIMARY KEY AUTO_INCREMENT,
c_name VARCHAR(255) NOT NULL,
c_email VARCHAR(255) NOT NULL UNIQUE
);
```

```sql
CREATE TABLE IF NOT EXISTS orders(
o_id INT PRIMARY KEY AUTO_INCREMENT,
c_id INT ,
o_date DATETIME DEFAULT CURRENT_TIMESTAMP

ON DELETE CASCADE
ON UPDATE CASCADE
);
```

Now as we see the error at 1:34:00 that if we set the c_id INT NOT NULL - in orders table that means we cannot use the refrencial aciton for on update and delete to NULL as it creates a conflict.

---

```sql
CREATE TABLE IF NOT EXISTS customers (
c_id INT PRIMARY KEY AUTO_INCREMENT,
c_name VARCHAR(255) NOT NULL,
c_email VARCHAR(255) NOT NULL UNIQUE
);
```

```sql
CREATE TABLE IF NOT EXISTS orders (
o_id INT PRIMARY KEY AUTO_INCREMENT,
c_id INT,
o_date DATETIME DEFAULT CURRENT_TIMESTAMP

CONSTRAINT oreders_foreign_key FOREIGN KEY (c_id) REFERENCES customers(c_id)

ON DELETE SET NULL
);
```

Here we use SET NULL - for deleting as there is no point on setting null for update at all. So now if we delete the customer from customers table the order table will fill the NULL values.

---

Similary we can set to any other value on DELETE, we dont have to set any default value on update as that does not make sense.

```sql
CREATE TABLE IF NOT EXISTS customers(
c_id INT PRIMARY KEY AUTO_INCREMENT,
c_name VARCHAR(255) NOT NULL ,
c_mail VARCHAR(255) NOT NULL UNIQUE
);

```

```sql
CREATE TABLE IF NOT EXISTS orders(
o_id INT PRIMARY KEY AUTO_INCREMENT,
c_id INT,
o_date DATETIME DEFAULT CURRENT_TIMESTAMP

CONSTRAINT orders_foreign_key FOREIGN KEY (c_id) REFERENCES customers(c_id)

ON DELETE SET DEFAULT "No DATA Avilable"
);
```

⚠⚠⚠⚠ Here we have similar issue - as we have set c_id INT and we are trying to use set default with string value which makes it invalid.

---

### Alter commnad

Alter allows to alter the structure of the perticular existing table.

1. Add new column (ADD)
2. Drop existing column (DROP)
3. Rename existing column (RENAME)
4. Change data type (MODIFY)
5. Set Default - use alter inside alter
6. and more

```sql
ALTER TABLE customers ADD COLUMN IF NOT EXISTS password VARCHAR(255) NOT NULL;
```

```sql
ALTER TABLE customers DROP COLUMN IF EXISTS password;
```

```sql
ALTER TABLE customers ALTER COLUMN IF EXISTS passoword SET DEFAULT "1234";
```

```sql
ALTER TABLE customers ADD COLUMN IF NOT EXISTS middle_name VARCHAR(255) NOT NULL AFTER c_name;
```

```sql
ALTER TABLE customers ADD COLUMN IF NOT EXISTS middle_name VARCHAR(255) NOT NULL FIRST;
```

| Subcommand                        | Use Case                                              | What It Does                                                  | Example                                                                                          |
| --------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| `ADD COLUMN`                    | Add a new column to the table                         | Adds a column with specified name, type, and optional default | `ALTER TABLE users ADD COLUMN age INT DEFAULT 18;`                                             |
| `DROP COLUMN`                   | Remove a column                                       | Deletes the column and all its data                           | `ALTER TABLE users DROP COLUMN age;`                                                           |
| `MODIFY COLUMN`                 | Change data type, default, or constraints (MySQL)     | Alters column's type or default value                         | `ALTER TABLE users MODIFY COLUMN name VARCHAR(100) NOT NULL;`                                  |
| `CHANGE COLUMN`                 | Rename column and change its type (MySQL only)        | Renames and modifies column in one go                         | `ALTER TABLE users CHANGE COLUMN name full_name VARCHAR(100);`                                 |
| `ALTER COLUMN ... SET DEFAULT`  | Set default value for a column (MySQL 8+, PostgreSQL) | Sets a new default for the column                             | `ALTER TABLE users ALTER COLUMN age SET DEFAULT 21;`                                           |
| `ALTER COLUMN ... DROP DEFAULT` | Remove default value                                  | Removes the default assigned to the column                    | `ALTER TABLE users ALTER COLUMN age DROP DEFAULT;`                                             |
| `ALTER COLUMN ... TYPE`         | Change data type (PostgreSQL)                         | Changes the column type                                       | `ALTER TABLE users ALTER COLUMN age TYPE SMALLINT;`                                            |
| `RENAME COLUMN`                 | Rename a column (MySQL 8.0+, PostgreSQL)              | Changes the column name only                                  | `ALTER TABLE users RENAME COLUMN name TO username;`                                            |
| `RENAME TO`                     | Rename a table                                        | Changes the name of the entire table                          | `ALTER TABLE users RENAME TO customers;`                                                       |
| `ADD CONSTRAINT`                | Add a constraint (e.g., foreign key, unique)          | Adds a named constraint to the table                          | `ALTER TABLE orders ADD CONSTRAINT fk_customer FOREIGN KEY (c_id) REFERENCES customers(c_id);` |
| `DROP CONSTRAINT`               | Remove a constraint (PostgreSQL)                      | Drops a named constraint                                      | `ALTER TABLE orders DROP CONSTRAINT fk_customer;`                                              |
| `ADD PRIMARY KEY`               | Add primary key after table creation                  | Assigns one or more columns as primary                        | `ALTER TABLE users ADD PRIMARY KEY (user_id);`                                                 |
| `DROP PRIMARY KEY`              | Remove primary key (MySQL only)                       | Removes the primary key from the table                        | `ALTER TABLE users DROP PRIMARY KEY;`                                                          |
| `ADD UNIQUE`                    | Enforce unique values in column(s)                    | Prevents duplicate entries                                    | `ALTER TABLE users ADD UNIQUE (email);`                                                        |
| `ADD INDEX`                     | Add an index to improve performance                   | Speeds up queries on the column                               | `ALTER TABLE users ADD INDEX (email);`                                                         |
| `DROP INDEX`                    | Remove an index                                       | Deletes the index                                             | `ALTER TABLE users DROP INDEX email;`                                                          |

```sql
ALTER TABLE customers
ADD NEW COLUMN IF NOT EXISTS sin_number INT,
ADD NEW COLUMND IF NOT EXISTS joining_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
```

We can also add and delete constraint.

```sql
ALTER TABLE orders CHANGE COLUMN o_id order_id INT;
```

To change the column name there is a wierd syntax of CHANGE COLUMN then original name followed by new name and the data type. Here data type is very important.
